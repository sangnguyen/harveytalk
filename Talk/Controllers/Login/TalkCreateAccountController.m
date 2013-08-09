
#import "TalkCreateAccountController.h"
#import "UIView+Ext.h"
#import "UIAlertView+Ext.h"
#import "DIOSUser.h"


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
    NSString* emailText = self->emailTextField.text;
    NSString* retypeEmailText = self->retypeEmailTextField.text;
    NSString* passwordText = self->passwordTextField.text;
    NSString* etypePasswordText = self->retypePasswordTextField.text;
    
    NSMutableDictionary *userData = [NSMutableDictionary new];
    [userData setObject:emailText forKey:@"name"];
    [userData setObject:emailText forKey:@"mail"];
    [userData setObject:passwordText forKey:@"pass"];
    [DIOSUser
        userRegister:userData
        success:^(AFHTTPRequestOperation *op, id response) { /* Handle successful operation here */
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"Information has been saved" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        failure:^(AFHTTPRequestOperation *op, NSError *err) { /* Handle operation failire here */
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not success Drupal" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
     ];
    
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
