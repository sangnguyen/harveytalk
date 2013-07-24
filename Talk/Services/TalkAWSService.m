
#import "TalkAWSService.h"
#import <AWSiOSSDK/S3/AmazonS3Client.h>
@implementation TalkAWSService


#define VIDEO_BUCKET @"video-bucket"

#define AMAZON_S3_HOST @".s3.amazonaws.com/"

const int PART_SIZE = (5 * 1024 * 1024); // 5MB is the smallest part size allowed for a multipart upload. (Only the last part can be smaller.)

@synthesize delegate,tag,publicProfileId,xmppUser,strDateSend,keyGlobal;

- (id)init{
    self = [super init];
    if (self != nil) {
        sentBytes = 0;
    }
    return self;
}

/**
 * get a part of data to upload multipart
 * @param part order of part to get
 * @parm filePath get path from this file path
 * @return data of this part
 */
-(NSData*)getPart:(int)part fromFile:(NSString*)filePath 
{
    int length = PART_SIZE;
    int location = part * PART_SIZE;
    
    int maxByte = (part + 1) * PART_SIZE;
    int fileLength = [FileHelper getFileLengthFromPath:filePath];
    if ( fileLength < maxByte ) {
        length = fileLength - location;
    }
    
    return [FileHelper readDatafromFile:filePath From:location lenght:length];
}


/**
 * number of parts in this file
 * @param filePath count parts in this file path
 * @return number of parts
 */
-(int)countParts:(NSString*)filePath 
{
    
    int q = (int)([FileHelper getFileLengthFromPath:filePath] / PART_SIZE);
    int r = (int)([FileHelper getFileLengthFromPath:filePath]  % PART_SIZE);
    
    return ( r == 0 ) ? q : q + 1;
}

/**
 * Check wifi available or not
 * @return available or not
 */
-(BOOL)isWifiAvailable 
{
    Reachability *r = [Reachability reachabilityForLocalWiFi];
    return !( [r currentReachabilityStatus] == NotReachable); 
}

/**
 * Call to upload file to s3, decide to upload by single request or multipart
 * @param filePath path of file to upload
 * @param bucket upload to this bucket on s3
 * @param key key of file to upload (ofent is file name)
 */
- (void) uploadFile:(NSString*)filePath bucket:(NSString*)bucket forKey:(NSString*)key{
    DLog(@"filePath: %@",filePath);
    sentBytes = 0;
    totalFileLength = [FileHelper getFileLengthFromPath:filePath];
    int fileLength = [FileHelper getFileLengthFromPath:filePath];
    if (fileLength <= PART_SIZE) {
        [self uploadFileWithSingleRequest:filePath bucket:bucket forKey:key];
    }else{
        [self uploadFileWithMultipart:filePath bucket:bucket forKey:key];
    }
}

/**
 * Get url of file on s3 from the url of Talk server
 * @param path the url from Talk server
 * @return new url to access file on s3
 */
- (NSURL*) genFileURLFromPath:(NSString*)path{
    NSArray* initArray1 = [path componentsSeparatedByString:@"https://"];
    if(!initArray1 || [initArray1 count] <2)
        return nil;
    NSString *path1 = [initArray1 objectAtIndex:1];
    NSArray* initArray2 = [path1 componentsSeparatedByString:AMAZON_S3_HOST];
    NSString *bucket = [initArray2 objectAtIndex:0];
    NSString *path2 = [initArray2 objectAtIndex:1];
    NSArray* initArray3 = [path2 componentsSeparatedByString:@"?AWSAccessKeyId="];
    NSString *key = [initArray3 objectAtIndex:0];
    DLog(@"log key here %@",key);
    return [self getFileURL:bucket key:key ];
}

/**
 * get the url to access file on s3 from key and bucket
 * @param bucket file in this bucket
 * @param key the key of file on s3
 */
- (NSURL*) getFileURL:(NSString*)bucket key:(NSString*)key{
    // Initial the S3 Client.
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY_ID withSecretKey:AWS_SECRET_KEY] ;
    
    @try {
        // Request a pre-signed URL to picture that has been uplaoded.
        S3GetPreSignedURLRequest *gpsur = [[S3GetPreSignedURLRequest alloc] init];
        gpsur.key                     = key;
        gpsur.bucket                  = bucket;
        gpsur.expires                 = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) 7200]; // Added an hour's worth of seconds to the current time.
        
        // Get the URL
        return  [s3 getPreSignedURL:gpsur];
    }
    @catch (AmazonClientException *exception) {
        return nil;
    }
}

/**
 * upload file to s3 with single request
 * @param filePath path to file in local
 * @param bucket upload to this bucket on s3
 * @param key key of file on s3
 */
- (void) uploadFileWithSingleRequest:(NSString*)filePath bucket:(NSString*)bucket forKey:(NSString*)key{
    bool using3G = ![self isWifiAvailable]; 
    bucketGlobal = bucket;
    keyGlobal = key;
    @try {	
        AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY_ID withSecretKey:AWS_SECRET_KEY];
        
        S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:key inBucket:bucket]; 
        currentSingleRequest = por;
        S3UploadInputStream *stream = [S3UploadInputStream inputStreamWithFileAtPath:filePath];  
        isComplete = NO;
//        s3.timeout = 600;
        if ( using3G ) {
            // If connected via 3G "throttle" the stream.
            stream.delay = 0.2; // In seconds
            stream.packetSize = 16; // Number of 1K blocks
        }
        
        por.contentLength = [FileHelper getFileLengthFromPath:filePath];
        por.stream = stream;
        [por setDelegate:self];
        
        [s3 putObject:por];
        
    }
    @catch ( AmazonServiceException *exception ) {
        DLog( @"Upload Failed, Reason: %@", exception );
        isComplete = YES;
        if (delegate &&[delegate respondsToSelector:@selector(didUploadFileFailed:sender:)]) {
            [delegate didUploadFileFailed:[[exception error] localizedDescription] sender:self];
        }
    }
}

/**
 * upload file to s3 with multipart request
 * @param filePath path to file in local
 * @param bucket upload to this bucket on s3
 * @param key key of file on s3
 */
- (void) uploadFileWithMultipart:(NSString*)filePath bucket:(NSString*)bucket forKey:(NSString*)key{
    [AmazonLogger verboseLogging];
    bool using3G = ![self isWifiAvailable];
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY_ID withSecretKey:AWS_SECRET_KEY];
    bucketGlobal = bucket;
    keyGlobal = key;
    @try {
        
        S3InitiateMultipartUploadRequest *initReq = [[S3InitiateMultipartUploadRequest alloc] initWithKey:key inBucket:bucket] ;
        S3MultipartUpload *upload = [s3 initiateMultipartUpload:initReq].multipartUpload;
        S3CompleteMultipartUploadRequest *compReq = [[S3CompleteMultipartUploadRequest alloc] initWithMultipartUpload:upload];        
        isComplete = NO;
        int numberOfParts = [self countParts:filePath];        
        for ( int part = 0; part < numberOfParts; part++ ) {
            NSData *dataForPart = [self getPart:part fromFile:filePath];
            
            S3UploadInputStream *stream = [S3UploadInputStream inputStreamWithData:dataForPart];        
            if ( using3G ) {
                // If connected via 3G "throttle" the stream.
                stream.delay = 0.2; // In seconds
                stream.packetSize = 16; // Number of 1K blocks
            }
            
            S3UploadPartRequest *upReq = [[S3UploadPartRequest alloc] initWithMultipartUpload:upload];
            currentMultipartUploadRequest = upReq;
            upReq.partNumber = ( part + 1 );
            upReq.contentLength = [dataForPart length];
            upReq.stream = stream;
            upReq.delegate = self;
            S3UploadPartResponse *response = [s3 uploadPart:upReq];            
            [compReq addPartWithPartNumber:( part + 1 ) withETag:response.etag];            
        }
        
        [s3 completeMultipartUpload:compReq];
    }
    @catch ( AmazonServiceException *exception ) {
        DLog( @"Multipart Upload Failed, Reason: %@", exception  );
        isComplete = YES;
        if (delegate && [delegate respondsToSelector:@selector(didUploadFileFailed:sender:)]) {
            [delegate didUploadFileFailed:[[exception error] localizedDescription] sender:self];
        }
    }
}

#pragma mark AmazonServiceRequestDelegate

/**
 * Call when sent data successfully to s3
 */
- (void)request:(AmazonServiceRequest *)request didSendData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    sentBytes += bytesWritten;
    DLog(@"have just sent %d - total sent %d - total filelength %d",bytesWritten,sentBytes,totalFileLength);
    if(delegate &&[delegate respondsToSelector:@selector(updateUploadProgress:)]){
        [delegate updateUploadProgress:((float)sentBytes/(float)totalFileLength)];
    }
}

/**
 * Call this when complete request
 */
- (void)request:(AmazonServiceRequest *)request didCompleteWithResponse:(AmazonServiceResponse *)response{
    isComplete = YES;
    DLog(@"Upload to amazon complete: %@",response);
    if (response.exception == nil  && !response.didTimeout) {
        NSURL* url = [self getFileURL:bucketGlobal key:keyGlobal];
        //DLog(@"I love this url %@",[url absoluteString]);
        if (delegate &&[delegate respondsToSelector:@selector(didUploadFileComplete:withKey:sender:)]) {
            [delegate didUploadFileComplete:[url absoluteString] withKey:keyGlobal sender:self];
        }
    }else{
        DLog( @"Upload Failed, Reason: %@", response.exception );
        if (delegate &&[delegate respondsToSelector:@selector(didUploadFileFailed:sender:)]) {
            [delegate didUploadFileFailed:[response.exception reason] sender:self];
        }
    }
}

-(void)request:(AmazonServiceRequest *)request didFailWithServiceException:(NSException *)exception{
    DLog(@"Receive exeception: %@",exception);
    NSString *message =@"";
    if ([exception isKindOfClass:[AmazonServiceException class]]) {
        AmazonServiceException *exp = (AmazonServiceException*)exception;
        if ([exp.errorCode isEqualToString:@"RequestTimeTooSkewed"]) {
            message = @"Upload failed because the system time is incorrect, please go to Settings to update your system time";
        }
        else{
            message = exp.message;
        }
    }
    if (message.length > 0) {
        //[TalkUIAlertView alert:localizeString(@"Upload File") message:message];
        DLog(@"Upload file failed: %@",message);
    }
}


- (void)request:(AmazonServiceRequest *)request didFailWithError:(NSError *)error{
    //[TalkUIAlertView alert:localizeString(@"Upload Failed") message:localizeString([error localizedDescription])];
    DLog(@"Upload file failed: %@",[error localizedDescription]);
}

// stop current request
- (void) stopRequest{
    if (currentSingleRequest && !isComplete ) {
        [currentSingleRequest.urlConnection cancel];
    }
    if (currentMultipartUploadRequest && !isComplete) {
        [currentMultipartUploadRequest.urlConnection cancel];
    }
    
}


@end
