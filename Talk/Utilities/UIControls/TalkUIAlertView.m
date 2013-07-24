

#import "TalkUIAlertView.h"
@implementation TalkUIAlertView



+ (void) alert:(NSString *)title message:(NSString *)message{
       
    [TalkUIAlertView alert:title message:message delegate:nil cancelButtonTitle:Localize(@"OK") otherButtonTitles:nil];
}
+ (void) alertWithoutCache:(NSString *)title message:(NSString *)message{
            
    [TalkUIAlertView alert:title message:message delegate:nil cancelButtonTitle:Localize(@"OK") otherButtonTitles:nil];
    
}

+ (void) alert:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    // No show with empty message
    if (!message) {
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:message 
                                                   delegate:delegate 
                                          cancelButtonTitle:cancelButtonTitle 
                                          otherButtonTitles:otherButtonTitles, nil];
    [alert show];
}

+ (void)ask:(NSString *)message title:(NSString *)title tag:(NSInteger)tag delegate:(id<UIAlertViewDelegate>)delegate{
    UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.tag = tag;
    [alert  show];
}



+ (UIAlertView*) alert:(NSString *)title
       message:(NSString *)message 
onButtonsDidTouch:(void (^)(NSUInteger buttonIndex, UIAlertView *alertView))onButtonsDidTouch 
cancelButtonTitle:(NSString *)cancelButtonTitle 
otherButtonTitles:(NSString *)otherButtonTitles, ...{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message completionBlock:^(NSUInteger buttonIndex, UIAlertView *alertView) {
        onButtonsDidTouch(buttonIndex,alertView);
    } cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    [alert show];
    return alert;
}

static NSDate * lastShowDate = nil;
+ (void) showNetworkErrorMessageIfNeeded: (BOOL) forceShow
{
    if(lastShowDate == nil || forceShow || abs([lastShowDate timeIntervalSinceNow]) > 60)
    {
        [TalkUIAlertView alert:@"Network error" message:@"Check your network connection and please try again"];
        lastShowDate = [NSDate date];
    }
}

+ (void) resetNetworkErrorMessageShowStatus
{
    lastShowDate = nil;
}

@end
