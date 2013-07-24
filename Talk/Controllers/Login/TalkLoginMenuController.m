

#import "TalkLoginMenuController.h"
#import "AFHTTPRequestOperation.h"
#import "TalkCreateAccountController.h"
#import "TalkForgotPasswordController.h"
#import "UIView+Ext.h"





@implementation TalkLoginMenuController

- (void)viewDidLoad{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookDidLogin) name:kFaceBookDidLogin object:nil];
   
}

- (IBAction)loginButtonDidTouch:(id)sender {
    //TODO
}
- (IBAction)forgotPasswordDidTouch:(id)sender {
    TalkForgotPasswordController * controller = [[TalkForgotPasswordController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)createAccountDidTouch:(id)sender {
    TalkCreateAccountController * controller = [[TalkCreateAccountController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)loginViaFacebookDidTouch:(id)sender {
     [[FBSession activeSession] closeAndClearTokenInformation];
    facebookToken = nil;
    facebookExpiredDate = nil;
    
    if([FBSession activeSession].state == FBSessionStateOpen ) // the fb token still valid we don't need to go to facebook app
    {
        [self facebookDidLogin];
    }
    else
    {
        [[FBSession activeSession] closeAndClearTokenInformation];
        [[FBSession activeSession] close];
        [FBSession setActiveSession:nil];
        [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            

            if (status == FBSessionStateOpen ) {
                //success
                [[NSNotificationCenter defaultCenter] postNotificationName:kFaceBookDidLogin object:nil];
            }else if(status == FBSessionStateClosed || status == FBSessionStateClosedLoginFailed)
            {
               

                [[FBSession activeSession] closeAndClearTokenInformation];
                [[FBSession activeSession] close];
                [FBSession setActiveSession:nil];
                
            }
            else{
                NSLog(@"Login error 3%@",FBSession.activeSession.accessToken);
            }
        }];
    }
   
}
- (void) facebookDidLogin{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFaceBookDidLogin object:nil];
   //TODO
}

#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == emailTextField) [passwordTextField becomeFirstResponder];
    else [textField resignFirstResponder];
    return YES;
}
@end
