

#import "UIImageView+Ext.h"
 #import "QuartzCore/CALayer.h"

@implementation UIImageView (Ext)

- (void) showShadowAround {
//    UIImage *shadow = [UIImage imageNamed:@"guideline_bar_shadow"];
    float shadowSize = 20;// image guideline_bar_shadow.png height
    
    // Original frame
//    CGRect originalFrame = self.frame;
    // New frame
    CGRect newFrame = self.frame;
    newFrame.origin.y -= shadowSize;
    newFrame.origin.x -= shadowSize;
    newFrame.size.height += shadowSize*2;
    newFrame.size.width += shadowSize*2;
    self.frame = newFrame;    
    
//    UIImage *currentImage = self.image;

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 1.0f};
    CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.5f}; 
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    
    CGPoint gradCenter= CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    float gradRadius = MIN(self.frame.size.width , self.frame.size.height) ;
    
    CGContextDrawRadialGradient (context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);    
    
    
    
    
//    [shadow drawInRect:CGRectMake(shadowSize, 0, originalFrame.size.width, shadowSize)];    
//    
//    // Bottom border
//    UIImage* topImage = [UIImage imageWithCGImage:shadow.CGImage                                       
//                                            scale:1.0 
//                                      orientation:UIImageOrientationDown];
//    [topImage drawInRect:CGRectMake(0, shadowSize + originalFrame.size.height, originalFrame.size.width, shadowSize)];    
//    
//    // Right border
//    UIImage* rightBorder = [UIImage imageWithCGImage:shadow.CGImage                                       
//                                            scale:1.0 
//                                      orientation:UIImageOrientationRight];
//    [rightBorder drawInRect:CGRectMake(originalFrame.size.width + shadowSize, 0, shadowSize, newFrame.size.height)];    
//    
//    // Left border
//    UIImage* leftBorder = [UIImage imageWithCGImage:shadow.CGImage                                       
//                                               scale:1.0 
//                                         orientation:UIImageOrientationLeft];
//    [leftBorder drawInRect:CGRectMake(0, 0, shadowSize, newFrame.size.height)];    
//    
//    // Apply supplied opacity if applicable
//    [currentImage drawInRect:CGRectMake(shadowSize, shadowSize, originalFrame.size.width, originalFrame.size.height) blendMode:0 alpha:1.0f];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    
    // Use new image
    [self setImage:newImage];   
}


- (void) showShadow{	
//	self.layer.shadowColor = [UIColor blackColor].CGColor;
//	self.layer.shadowOpacity = 1.0f;
//	self.layer.shadowOffset = CGSizeMake(0, 8.0f);
//	self.layer.shadowRadius = 7.0f;
//	self.layer.masksToBounds = NO;
//    CGSize size = self.bounds.size;	
//	UIBezierPath *path = [UIBezierPath bezierPath];
//	[path moveToPoint:CGPointMake(-10.0f, 0.0f)];
//	[path addLineToPoint:CGPointMake(size.width +10.0f, 0.0f)];
//	[path addLineToPoint:CGPointMake(size.width * 1.15f, -8.0f)];
//	[path addLineToPoint:CGPointMake(size.width * -0.15f, -8.0f)];
//    self.layer.shadowPath = path.CGPath;    
    
    UIImage *shadow = [UIImage imageNamed:@"guideline_bar_shadow"];
    float shahowH = 14;// image guideline_bar_shadow.png height
    float imaggH = self.image.size.height;
    CGRect frame =  self.frame;
    frame.origin.y -= shahowH;
    frame.size.height +=14;
    self.frame = frame;    
    UIImage *currentImage = self.image;
    CGSize newSize = CGSizeMake(self.image.size.width, imaggH + shahowH);
    UIGraphicsBeginImageContext( newSize );
    // Use existing opacity as is
    [shadow drawInRect:CGRectMake(0,0,shadow.size.width,shahowH)];    
    // Apply supplied opacity if applicable
    [currentImage drawInRect:CGRectMake(0,newSize.height-imaggH,newSize.width,imaggH) blendMode:0 alpha:1.0f];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    [self setImage:newImage];    
}
@end
