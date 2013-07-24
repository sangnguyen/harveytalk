

#import "TalkHTTPService.h"
#import "AFJSONRequestOperation.h"
#import "NSString+SBJSON.h"

#import "AFAmazonS3Client.h"

@implementation TalkHTTPService

#define showRequestErrorMessageLogKey @"showRequestErrorMessageLogKey"

+ (TalkHTTPService *) sharedInstance{
    static TalkHTTPService *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _sharedClient = [[TalkHTTPService alloc] initWithBaseURL:[NSURL URLWithString:kTalkAPIHost]];
    });
    return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    requestLog = [[NSMutableDictionary alloc] initWithCapacity:1];
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json,text/html"];
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];            
    [self setParameterEncoding:AFJSONParameterEncoding];
    return self;
}


- (void) setKeepSilentWhenErrorAtPath:(NSString*)path{
    NSString *key = [NSString stringWithFormat:@"%@_AT_PATH_%@",showRequestErrorMessageLogKey,path];
    [requestLog setValue:path forKey:key];
}

- (BOOL) shouldShowErrorAtPath:(NSString*)path{
    //If user like a deleted post
    if ([path rangeOfString:@"social_stream/like?auth_token"].length > 0) {
        return YES;
    }
    NSString *key = [NSString stringWithFormat:@"%@_AT_PATH_%@",showRequestErrorMessageLogKey,path];    
    if ([[requestLog allKeys] containsObject:key]) {
        [requestLog removeObjectForKey:key];
        return TRUE;
    }
    return FALSE;
}

/**
 Request executed success, but got error from Server, fail case was fired
 */
- (void) catchFailMessageWhenAFHTTPOperationSuccess:(AFHTTPRequestOperation *) operation error:(NSString *) responseString path:(NSString*)path{
    NSString *message = [TalkErrorService getErrorMessage:operation];
    
}






#pragma mark UPDATE LOCATION

/**
 * override put method to update current location
 */
-(void)commitLocation:(NSString *)targetUrl parameters:(NSDictionary *)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    [super putPath:targetUrl parameters:parameters 
           success:^(AFHTTPRequestOperation * operation, NSString * responseString){
               int statusCode = [operation.response statusCode];                
               if (statusCode >= 400) {
                   NSDictionary *errorInfo = [[NSDictionary alloc] 
                                              initWithObjectsAndKeys:[responseString JSONValue],NSLocalizedDescriptionKey, nil];
                   NSError *error = [NSError errorWithDomain:kXmppServer code:statusCode userInfo:errorInfo];
                   failure(error);
               }else{
                   success([responseString JSONValue]);
               }
           }
           failure:^ (AFHTTPRequestOperation *operation, NSError *error){
             //  [self catchErrorResponseOnAFHTTPOperation:operation error:error];//Sang removed because no need to notice to user if updating location fail
               failure(error);
           }];
}


- (void)cancelAllOperation{
    [self.operationQueue cancelAllOperations];
   

}

@end
