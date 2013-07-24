

#import "TalkSplashController.h"

#import "TalkLoginMenuController.h"

@implementation TalkSplashController
/** 
 * Show Login Screen screen 
 * Called when no login screen
 */
- (void) showLoginScreen{
   
    TalkLoginMenuController *controller = [[TalkLoginMenuController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - View life cycles
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self performSelector:@selector(showLoginScreen) withObject:nil afterDelay:3];
   
}

@end
