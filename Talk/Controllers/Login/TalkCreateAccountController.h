// Dai Bui

#import "TalkBaseController.h"


@interface TalkCreateAccountController : TalkBaseController<UITextFieldDelegate>{
    IBOutlet UITextField *emailTextField;
    IBOutlet UITextField *retypeEmailTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *retypePasswordTextField;
    IBOutlet UIButton *createAccountButton;
    IBOutlet UIButton *backButton;
   
}

@end
