

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define LOAD_MORE_HEADER_HEIGHT 30

@interface TalkLoadMoreView : UIView{
    UILabel *loadMoreLabel;
    UIActivityIndicatorView *loadMoreSpinner;
}

@property(nonatomic, retain) IBOutlet UILabel *loadMoreLabel;
@property(nonatomic, retain) IBOutlet UIImageView *loadMoreArrow;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *loadMoreSpinner;

-(void)setReleaseView;
-(void)setReleaseToLoadMore ;
-(void)setReleaseView:(NSString*)text;

-(void)setPullView;
-(void)setPullView:(NSString*)text;

-(void)setLoadingView;
-(void)setLoadingView:(NSString*)text;

-(void)setStopLoading;
@end
