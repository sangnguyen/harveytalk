

#import "UIAlertView+Modal.h"

@implementation UIModalAlertView

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
    completionBlock:(void (^)(NSUInteger buttonIndex, UIModalAlertView *alertView,BOOL *shouldDismiss))completionBlock 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    dismissWhenClickOk = TRUE;
	objc_setAssociatedObject(self, "completionBlockCallback", [completionBlock copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil]) {
		
		if (cancelButtonTitle) {
			[self addButtonWithTitle:cancelButtonTitle];
			self.cancelButtonIndex = [self numberOfButtons] - 1;
		}
		
		id eachObject;
        
		va_list argumentList;
        
		if (otherButtonTitles) {
			[self addButtonWithTitle:otherButtonTitles];
			va_start(argumentList, otherButtonTitles);
			while ((eachObject = va_arg(argumentList, id))) {
				[self addButtonWithTitle:eachObject];
			}
			va_end(argumentList);
		}
	}	
	return self;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    if (buttonIndex == 1) {
        // When press OK
        if(!dismissWhenClickOk){
            return;
        }
    }
    return [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	void (^block)(NSUInteger buttonIndex, UIAlertView *alertView,BOOL *shouldDismiss) = objc_getAssociatedObject(self, "completionBlockCallback");
	block(buttonIndex, self, &dismissWhenClickOk);
}

- (void)showAlertWithTextField:(NSString *)placeHolderText{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        self.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[self textFieldAtIndex:0] setPlaceholder:placeHolderText];        
    }
    else{
        //Change the alert size
        //Move 2 buttons to below
        
        NSString *message = [self message];
        message = [message stringByAppendingString:@"\n\n\n"];
        [self setMessage:message];
        
        //Add textfield
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 100.0, 260.0, 30.0)];
        [textfield setPlaceholder:placeHolderText];
        [textfield setBackgroundColor:[UIColor whiteColor]];
        [textfield setKeyboardAppearance:UIKeyboardAppearanceAlert];
        [textfield setAutocorrectionType:UITextAutocorrectionTypeNo];
        [textfield setTextAlignment:UITextAlignmentLeft];
        [textfield setBorderStyle:UITextBorderStyleLine];
        [textfield setFont:[UIFont fontWithName:[[textfield font] familyName] size:20.0f]];
        [self addSubview:textfield];
        [textfield becomeFirstResponder];    
        [self becomeFirstResponder];
    }
    //Show alert view
    [self show];    
}

- (UITextField*)getTextFields:(NSInteger)index{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        return [self textFieldAtIndex:0];
    }
    else{
        NSInteger textFieldIndex = 0;
        for(UITextField *textfield in [self subviews]){
            if ([textfield isKindOfClass:[UITextField class]]){
                if (textFieldIndex == index)
                    return textfield;
                else
                    textFieldIndex++;
            }
        }
        return nil;
    }
}

@end
