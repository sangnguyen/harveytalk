

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "TalkErrorService.h"

@interface TalkHTTPStatusNet : AFHTTPClient
+ (TalkHTTPStatusNet *) statusNetClientWithUserName:(NSString*)userName password:(NSString*)password;
- (void) doUploadPhoto:(NSString*)targetUrl
                params:(NSDictionary *)params
               success:(void (^)(NSDictionary*))success
               failure:(void (^)(NSString *))failure;
- (void) doDeletePost:(NSString*)targetUrl
               params:(NSDictionary *)params
              success:(void (^)(NSDictionary*))success
              failure:(void (^)(NSString *))failure;
@end
