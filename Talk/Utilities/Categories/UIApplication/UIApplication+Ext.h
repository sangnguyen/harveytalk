

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>


@interface UIApplication (Ext)

/**
 * Returns the path to the application's Documents directory.
 */
- (NSString *) documentsDirectory;
- (NSString *) applicationVersion;
- (NSString *) applicationName;
@end
#endif