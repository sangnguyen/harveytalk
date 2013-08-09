

#import "TalkForgotPasswordController.h"
#import "UIView+Ext.h"
#import "DIOSUser.h"



@implementation TalkForgotPasswordController

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
    sendButton = nil;
    backButton = nil;
    [super viewDidUnload];
}
- (IBAction)backButtonDidTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendButtonDidTouch:(id)sender {
    //TODO
    NSString* emailText = self->emailTextField.text;
    [DIOSUser
        userSendPasswordRecoveryEmailWithEmailAddress:emailText
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"The password has been sent to the provided mail" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Some error appear here" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
     ];
}

#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self sendButtonDidTouch:nil];
    return YES;
}
@end
