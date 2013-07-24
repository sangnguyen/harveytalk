
#if TARGET_OS_IPHONE
#import "UIColor+Ext.h"

@implementation UIColor (Ext)

const NSInteger MAX_RGB_COLOR_VALUE = 0xff;
const NSInteger MAX_RGB_COLOR_VALUE_FLOAT = 255.0f;

+ (UIColor *) colorWithRGB:(uint) hex {
	return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
							blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT 
						   alpha:1.0];
}
- (CGFloat)r {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[0];
}

- (CGFloat)g {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[1];
}

- (CGFloat)b {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[2];
}

- (CGFloat)a {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	return rgba[3];
}
@end
#endif