

#import "TalkAWSS3Service.h"
#import "AFHTTPRequestOperation.h"

@implementation TalkAWSS3Service
+ (TalkAWSS3Service *) sharedInstance{
    static TalkAWSS3Service *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TalkAWSS3Service alloc] initWithAccessKeyID:AWS_ACCESS_KEY_ID secret:AWS_SECRET_KEY];
        instance.bucket = Talk_DEV_BUCKET;
    });
    return instance;
}

- (BOOL) isExistRequestAtURL:(NSURL*)url{
    NSArray *operations = [[self operationQueue] operations];
    for (AFHTTPRequestOperation *operation in operations) {
        if([[[[operation request] URL] lastPathComponent] isEqual:[url lastPathComponent]]){
            return YES;
        }
    }
    return NO;
}

- (void)getVideoFromUrl:(NSURL *)url
               progress:(void (^)(NSInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead))progress
                success:(void (^)(id responseObject, NSData *responseData))success
                failure:(void (^)(NSError *error))failure{
    if ([self isExistRequestAtURL:url]) {
        return;
    }
    NSString* fileName =[url lastPathComponent];
    NSURL *localFilePath = [NSURL fileURLWithPath:[[DOCUMENTS_DIR() stringByAppendingPathComponent:VIDEO_FOLDER] stringByAppendingPathComponent:fileName]];
    NSString *downloadPath = [NSString stringWithFormat:@"%@?%@",[[url lastPathComponent] urlEncode],[url query]];
    [self getObjectWithPath:downloadPath
                       progress:^(NSInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead) {
                           DLog(@"Download video: progress %d",bytesRead/totalBytesRead * 100);
                           if (progress) {
                               progress(bytesRead,totalBytesRead,totalBytesExpectedToRead);                               
                           }
                       } success:^(id responseObject, NSData *responseData) {
                           DLog(@"Download video: completed, write to file: %@",localFilePath);
                           [responseData writeToURL:localFilePath atomically:YES];
                           if (success) {
                               success(responseObject,responseData);                               
                           }
                       } failure:^(NSError *error) {
                           DLog(@"Download video: error: %@",error);
                           if (failure) {
                               failure(error);                               
                           }
                       }];
}
@end
