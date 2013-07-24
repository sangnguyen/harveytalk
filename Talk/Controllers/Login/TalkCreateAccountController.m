
#import "TalkCreateAccountController.h"
#import "UIView+Ext.h"
#import "UIAlertView+Ext.h"


@interface TalkCreateAccountController ()
- (IBAction)backButtonDidTouch:(id)sender;
- (IBAction)createAccountDidTouch:(id)sender;

@end

@implementation TalkCreateAccountController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
   
   
  
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view findAndResignFirstResponder];
}


- (void)viewDidUnload {
    emailTextField = nil;
    retypeEmailTextField = nil;
    passwordTextField = nil;
    retypePasswordTextField = nil;
    createAccountButton = nil;
    backButton = nil;
    
    [super viewDidUnload];
}
- (IBAction)backButtonDidTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)createAccountDidTouch:(id)sender {
    
    
}

#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == emailTextField) [retypeEmailTextField becomeFirstResponder];
    else if(textField == retypeEmailTextField) [passwordTextField becomeFirstResponder];
    else if(textField == passwordTextField) [retypePasswordTextField becomeFirstResponder];
    else [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
   
}
@end
