

#import "TalkAppDelegate.h"
#import "EmojiHelper.h"
#import "DBHelper.h"
#import "TalkLocationService.h"
#import "TalkSplashController.h"
#import <CommonCrypto/CommonDigest.h>

#import "TalkXMPPService.h"

TalkAppDelegate      *gAppDelegate = nil;

TalkXMPPService      *gXmpp = nil;
TalkDataFactory      *gDataService = nil;
TalkRevealController *gRevealController = nil;

@implementation TalkAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController,deviceToken = _deviceToken;

#pragma mark - Util methods
void TalkExceptionHandler (NSException *exception);


#pragma mark - Intialize Social Networks
- (void) initializeServices{
    // Init services
   // test
    
    gXmpp           = [TalkXMPPService sharedInstance];
}

#pragma mark - Handle app exception
/**
 * Handle app exception here
 */
extern void TalkExceptionHandler (NSException *exception);
void TalkExceptionHandler (NSException *exception){
    
   [[TalkXMPPService sharedInstance]disconnect];
   
}



#pragma mark - Application delegates
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    TalkSplashController *splash = [[TalkSplashController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:splash];
    [_window setRootViewController:_navigationController];
    
    [EmojiHelper enableEmoji];//Support send emoji when chating
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    NSSetUncaughtExceptionHandler(&TalkExceptionHandler);    
    [self initializeServices];
    return YES;
}



//-------------------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken_
{
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
   
    if([[userInfo objectForKey:@"code"] intValue] == 1001)
    {
       
    }else{
        if (application.applicationState == UIApplicationStateInactive) {
            NSLog(@"user infoooo %@",userInfo);
           
            
        }
    }
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    if (application.applicationState == UIApplicationStateInactive) {
        if ([[[notification userInfo] objectForKey:@"sender"] intValue] > 0) {
           
        }
    }
}





- (NSString*) getDeviceToken{
    NSString * deviceId = [[self.deviceToken encodeWithUTF8] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if(!deviceId || [deviceId isEqualToString: @""])
    {
        deviceId = @"49d1b61fcfa2fe14cedf564c3f271a6f321a9c95e5f7c4edeed1706ccbed57ce";
    }
    return deviceId;
}

@end
