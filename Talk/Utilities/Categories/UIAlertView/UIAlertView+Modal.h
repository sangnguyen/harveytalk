#import <Foundation/Foundation.h>

@interface UIModalAlertView: UIAlertView<UIAlertViewDelegate>{
    BOOL dismissWhenClickOk;
}
- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
    completionBlock:(void (^)(NSUInteger buttonIndex, UIModalAlertView *alertView,BOOL *shouldDismiss))completionBlock 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)showAlertWithTextField:(NSString*)placeHolderText;
- (UITextField*)getTextFields:(NSInteger)index;
@end
