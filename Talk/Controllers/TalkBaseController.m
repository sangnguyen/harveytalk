

#import "TalkBaseController.h"
#import "TalkAppDelegate.h"
#import "DBHelper.h"
#import "TalkSplashController.h"

@implementation TalkBaseController
@synthesize isIgnoreInvalidWarning, overlayToFadeOutView;

#pragma mark - getters / setters

- (void) hideNavigationBar:(BOOL)yesOrNo{
    
    if(yesOrNo)
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    else
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

                                    
- (id) initWithoutNib {
    self = [super init];
    if (self) {
    
    }
    
    return self;
}

- (id)init{
    NSString *controllerName = [[self class] description];
    NSString *viewName = [controllerName replace:@"Controller" with:@"View"];
    self = [super initWithNibName:viewName bundle:nil];
    return self;
}
-(BOOL)isLoaded
{
    return isLoaded;
}

#pragma mark - View life cycles
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self hideNavigationBar:NO];
    
   
    isOnForeground = YES;
    isLoaded =TRUE;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title 
                        backgroundImageName:(NSString *)imageName 
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Since the buttons can be any width we use a thin image with a stretchable center point
    UIImage *buttonImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = [title sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 24.0;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return buttonItem;
}




@end
