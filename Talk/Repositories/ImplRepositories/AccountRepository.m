

#import "AccountRepository.h"
#import "TalkHTTPService.h"
#import "NSString+Ext.h"
#import "TalkAppDelegate.h"
#import "TalkLocationService.h"
#import "JSON.h"
#import "JSONHelper.h"

#import "AFHTTPRequestOperation.h"
@implementation AccountRepository


/** 
 * Logout from Talk server
 * @param userToken the access token that got from login
 * @param success success callback block, return result json from server
 * @param failture failure callback block, return the error
 */
- (void) logout:(NSString*)userToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure { 
    NSString * targetURL = [NSString stringWithFormat:@"users/sign_out?auth_token=%@", userToken];             
    TalkHTTPService *service = [TalkHTTPService sharedInstance];
    
    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        DLog(@"%@",responseObject);
    };
    
    void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        failure([error localizedDescription]);        
    };    
    [service getPath:targetURL parameters:nil success:successBlock failure:failureBlock];
}


- (void) loginWithFacebookAccessToken:(NSString*)accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure{
    }

/**
 * Create Profile
 * @param accessToken the access token
 * @param success success callback block, return result json from server
 * @param failture failure callback block, return the error
 */
- (void) createProfile: (Profile *) profile accessToken: (NSString *) accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSUInteger ))failure{
    }

- (void) getCurrentProfileWithAccessToken: (NSString *) accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSError * error))failure
{
    
}


- (void) facebookUserInfoWithFacebookToken: (NSString *) fbAccessToken success:(void (^)(NSDictionary * jsonResult))success failure:(void (^)(NSError *))failure{
    }



- (void)  createAccountWithEmail: (NSString *) email password: (NSString *) password success: (void (^)(void)) success failure: (void (^)(NSString *)) failure{
    }

- (void)  signInWithEmail: (NSString *) email password: (NSString *) password isRemeberPassword: (BOOL) isRememberPassword success: (void (^)(NSDictionary *)) success failure: (void (^)(NSString *)) failure{
    }

@end
