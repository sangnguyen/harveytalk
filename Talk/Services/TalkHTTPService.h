

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "TalkErrorService.h"

@interface TalkHTTPService : AFHTTPClient{
    NSMutableDictionary *requestLog;
}

+ (TalkHTTPService *) sharedInstance;

- (void) setKeepSilentWhenErrorAtPath:(NSString*)path;

- (void)doUploadPhoto:(NSString*)targetUrl
                params:(NSDictionary *)params
               success:(void (^)(NSDictionary*))success 
               failure:(void (^)(NSString *))failure;

- (void)requestWithNSURLRequest:(NSURLRequest *)request 
                        success:(void (^)(NSDictionary*))success
                        failure:(void (^)(NSError *))failure;

- (void)commitLocation:(NSString*)targetUrl 
               parameters:(NSDictionary *)parameters
               success:(void (^)(NSDictionary*))success
               failure:(void (^)(NSError *))failure;

- (void)getPathWithoutErrorCaching:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure cacheError: (BOOL) willCacheError;
- (void)postPathWithoutErrorCaching:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
- (void)cancelAllOperation;
@end
