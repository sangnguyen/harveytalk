

#import <Foundation/Foundation.h>
/**
 Using AFS3Client lib to work with Amazone S3 service
 */
#import "AFAmazonS3Client.h"
@interface TalkAWSS3Service : AFAmazonS3Client
+ (TalkAWSS3Service *) sharedInstance;
- (void) getVideoFromUrl:(NSURL *)url
               progress:(void (^)(NSInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead))progress
                success:(void (^)(id responseObject, NSData *responseData))success
                failure:(void (^)(NSError *error))failure;
@end
