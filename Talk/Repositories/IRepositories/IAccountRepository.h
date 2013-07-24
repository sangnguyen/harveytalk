

#import <Foundation/Foundation.h>

@class Profile;
@protocol IAccountRepository<NSObject>

- (void) logout:(NSString*)userToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure;
- (void) createProfile: (Profile *) profile accessToken: (NSString *) accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSUInteger))failure;

- (void) uploadProfileImageSmall: (UIImage *) smallSizeImage big: (UIImage *) bigSizeImage doubleSize: (UIImage *) doubleSizeImage accessToken: (NSString *) accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

- (void) loginWithFacebookAccessToken:(NSString*)accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure;

//facebok
- (void) facebookUserInfoWithFacebookToken: (NSString *) fbAccessToken success:(void (^)(NSDictionary * jsonResult))success failure:(void (^)(NSError *))failure;
- (void) facebookPhotoWithFacebookToken: (NSString *) fbAccessToken success:(void (^)(UIImage *, UIImage *,UIImage *, UIImage *))success failure:(void (^)(NSError *))failure;
- (void) verifyToken: (NSString *) token email: (NSString *) email success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure;

- (void)  createAccountWithEmail: (NSString *) email password: (NSString *) password success: (void (^)(void)) success failure: (void (^)(NSString *)) failure;
- (void)  signInWithEmail: (NSString *) email password: (NSString *) password isRemeberPassword: (BOOL) isRememberPassword success: (void (^)(NSDictionary *)) success failure: (void (^)(NSString *)) failure;
- (void)  retrievePasswordWithEmail: (NSString *) email success: (void (^)(void)) success failure: (void (^)(NSString *)) failure;
- (void) getCurrentProfileWithAccessToken: (NSString *) accessToken success:(void (^)(NSDictionary *))success failure:(void (^)(NSError * error))failure;
@end
