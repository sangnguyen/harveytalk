

#import "UIBarButtonItem+Ext.h"

@implementation UIBarButtonItem(Ext)
-(id)initWithImage:(UIImage *)image title:(NSString*)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height) ];
    [view addSubview:button];
    
    [self release];
    self = [[[UIBarButtonItem alloc] initWithCustomView:view] retain];
    
    [view release];
    [image release];
    return self;
}
@end
