

#import "TalkForgotPasswordController.h"
#import "UIView+Ext.h"



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
}

#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self sendButtonDidTouch:nil];
    return YES;
}
@end
