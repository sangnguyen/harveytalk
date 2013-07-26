

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "TalkAWSService.h"
#import "TestFlight.h"

#define HAS_CHECKED_EXPIRATION_AT_LAUCH @"check_expire_at_lauch"
/// Global variables
//
//
@class TalkAppDelegate;
extern TalkAppDelegate *gAppDelegate;

@class Facebook;
extern Facebook *gFacebook;

@class TalkXMPPService;
extern TalkXMPPService *gXmpp;

@class TalkDataFactory;
extern TalkDataFactory *gDataService;

@class TalkRevealController;
extern TalkRevealController *gRevealController;

@interface TalkAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>{
  
   
}
@property (strong, nonatomic) UIWindow  *window;
@property (strong, nonatomic) NSString  *deviceToken;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
