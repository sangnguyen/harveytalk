

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
void UIAlertViewQuick(NSString* title, NSString* message, NSString* dismissButtonTitle);
@interface UIAlertView (Ext)

@end
#endif