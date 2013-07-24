

#import <UIKit/UIKit.h>

#import "UIImageView+Ext.h"



@interface TalkBaseController : UIViewController <UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIActionSheet   *_actionSheetMain;
    UIAlertView     *_alertMain;   
    UIView* mView;
    BOOL isLoaded;
    UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
    
    @private
    BOOL isOnForeground;
  

}

@property(nonatomic,strong) UIView * overlayToFadeOutView;

@property (nonatomic, assign) BOOL isIgnoreInvalidWarning;

- (id) initWithoutNib;



@end
