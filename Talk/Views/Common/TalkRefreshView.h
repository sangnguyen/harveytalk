

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define REFRESH_HEADER_HEIGHT 50
@interface TalkRefreshView : UIView {
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
}

@property(nonatomic, retain) IBOutlet UILabel *refreshLabel;
@property(nonatomic, retain) IBOutlet UIImageView *refreshArrow;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *refreshSpinner;

-(void)setReleaseView;
-(void)setReleaseView:(NSString*)text;

-(void)setPullView;
-(void)setPullView:(NSString*)text;

-(void)setUpdating;
-(void)setUpdating:(NSString*)text;

@end