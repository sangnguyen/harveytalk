

#if TARGET_OS_IPHONE
#import "UIApplication+Ext.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIApplication (Ext)

- (NSString *)documentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)applicationVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
- (NSString *)applicationName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}
@end
#endif