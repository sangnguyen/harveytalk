
#import <Foundation/Foundation.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>

@protocol TalkAWSServiceDelegate;
@interface TalkAWSService : NSObject<AmazonServiceRequestDelegate>{
    int sentBytes;
    int totalFileLength;
    
    BOOL isComplete;
    
    NSString *bucketGlobal;
    NSString *keyGlobal;
    S3PutObjectRequest* currentSingleRequest;
    S3UploadPartRequest* currentMultipartUploadRequest;
}
@property (nonatomic,retain) id<TalkAWSServiceDelegate>delegate;
@property (nonatomic,assign) int publicProfileId;
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,retain) NSString* xmppUser;
@property (nonatomic,retain) NSString* strDateSend;
@property (nonatomic,readonly) NSString* keyGlobal;

- (NSURL*) getFileURL:(NSString*)bucket key:(NSString*)key;
- (void) uploadFileWithSingleRequest:(NSString*)filePath bucket:(NSString*)bucket forKey:(NSString*)key;
- (void) uploadFileWithMultipart:(NSString*)filePath bucket:(NSString*)bucket forKey:(NSString*)key;
- (void) uploadFile:(NSString*)filePath bucket:(NSString*)bucket forKey:(NSString*)key;
- (void) stopRequest;
- (NSURL*) genFileURLFromPath:(NSString*)path;
@end

@protocol TalkAWSServiceDelegate <NSObject>
- (void) didUploadFileComplete:(NSString*)filePath withKey:(NSString*)key sender:(TalkAWSService*)sender;
- (void) didUploadFileFailed:(NSString*)error sender:(TalkAWSService*)sender;
- (void)updateUploadProgress:(float)percent;
@end
