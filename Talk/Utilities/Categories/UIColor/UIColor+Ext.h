

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface UIColor (Ext)
@property (nonatomic, readonly) CGFloat r;
@property (nonatomic, readonly) CGFloat g;
@property (nonatomic, readonly) CGFloat b;
@property (nonatomic, readonly) CGFloat a;
+ (UIColor *) colorWithRGB:(uint) hex;
@end
#endif