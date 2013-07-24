

#import <Foundation/Foundation.h>


@interface TalkUIAlertView : NSObject<UIAlertViewDelegate>

+ (void) alert:(NSString *)title message:(NSString *)message;
+ (void) alertWithoutCache:(NSString *)title message:(NSString *)message;
+ (void) alert:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

+ (void)ask:(NSString *)message title:(NSString *)title tag:(NSInteger)tag delegate:(id<UIAlertViewDelegate>)delegate;

+ (UIAlertView*)  alert:(NSString *)title message:(NSString *)message onButtonsDidTouch:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))onButtonsDidTouch cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

/*
 * This method show Network Error message. 
 * It make sure only show the message once every 1mins unless forceShow = YES
 * @param forceShow: Force to show the message
 */
+ (void) showNetworkErrorMessageIfNeeded: (BOOL) forceShow;
+ (void) resetNetworkErrorMessageShowStatus;
@end
