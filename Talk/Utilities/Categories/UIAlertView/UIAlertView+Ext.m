
#if TARGET_OS_IPHONE
#import "UIAlertView+Ext.h"

void UIAlertViewQuick(NSString* title, NSString* message, NSString* dismissButtonTitle) {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title,@"") 
													message:NSLocalizedString(message,@"") 
												   delegate:nil 
										  cancelButtonTitle:NSLocalizedString(dismissButtonTitle,@"") 
										  otherButtonTitles:nil
						  ];
	[alert show];
	[alert autorelease];
}


@implementation UIAlertView (Ext)

@end
#endif