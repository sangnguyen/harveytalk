

#import "TalkLoadMoreView.h"

@implementation TalkLoadMoreView

@synthesize loadMoreLabel, loadMoreArrow, loadMoreSpinner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];

        // Create label
        loadMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, floorf((LOAD_MORE_HEADER_HEIGHT - 20) / 2), frame.size.width, 20)];
        loadMoreLabel.backgroundColor = [UIColor clearColor];
        loadMoreLabel.font = [UIFont boldSystemFontOfSize:12.0];
        loadMoreLabel.textAlignment = UITextAlignmentCenter;
        loadMoreLabel.contentMode = UIViewContentModeTop;
        loadMoreLabel.textColor = [UIColor whiteColor];
        
        // Create spinner
        loadMoreSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        loadMoreSpinner.frame = CGRectMake(90, floorf((LOAD_MORE_HEADER_HEIGHT - 20) / 2), 20, 20);
        loadMoreSpinner.hidesWhenStopped = YES;

        [self setHidden:YES];
 
        [self addSubview:loadMoreLabel];
        [self addSubview:loadMoreSpinner];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setReleaseView {
    [self setReleaseView:@"Release to refresh..."];
}

-(void)setReleaseToLoadMore {
    [self setReleaseView:@"Release to load more people..."];
}

-(void)setReleaseView:(NSString*)text
{
    loadMoreLabel.text = text;
    [loadMoreSpinner stopAnimating];
    self.hidden = NO;
}

-(void)setPullView {
    [self setPullView:@"Pull up to load more people..."];
}

-(void)setPullView:(NSString*)text
{
    loadMoreLabel.text = text;
    [loadMoreSpinner stopAnimating];
    self.hidden = NO;
}

-(void)setLoadingView {
    
    [self setLoadingView:@"Loading..."];
    [loadMoreSpinner startAnimating];
}

-(void)setLoadingView:(NSString*)text
{
    loadMoreLabel.text = text;
    self.hidden = NO;
}

-(void)setStopLoading
{
    self.hidden = YES;
    [loadMoreSpinner stopAnimating];
}

@end
