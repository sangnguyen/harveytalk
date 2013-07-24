

#import <UIKit/UIKit.h>
#import "TalkBaseController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface TalkLoginMenuController : TalkBaseController <UIAlertViewDelegate, UITextFieldDelegate>{
   
    IBOutlet UITextField *emailTextField;
    IBOutlet UITextField *passwordTextField;
    NSString * facebookToken ;
    NSDate * facebookExpiredDate ;
}

@end
