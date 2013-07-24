

#import "TalkBaseController.h"

@interface TalkForgotPasswordController : TalkBaseController<UITextFieldDelegate>{
    MBProgressHUD   *HUD;    
    IBOutlet UITextField *emailTextField;
    IBOutlet UIButton *sendButton;
    IBOutlet UIButton *backButton;
}

@end
