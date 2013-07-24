

#import "TalkRefreshView.h"

@implementation TalkRefreshView

@synthesize refreshLabel, refreshArrow, refreshSpinner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create label
        refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, frame.size.height)];
        refreshLabel.backgroundColor = [UIColor clearColor];
        refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
        refreshLabel.textAlignment = UITextAlignmentCenter;
        refreshLabel.textColor = [UIColor whiteColor];
        // Create arrow
        refreshArrow = [[UIImageView alloc] initWithFrame:CGRectMake(25, (floorf(frame.size.height - 44) / 2), 22, 44)];
        [refreshArrow setImage:[UIImage imageNamed:@"arrow_pull_white.png"]];
        self.backgroundColor = [UIColor clearColor];

        // Create spinner
        refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
        refreshSpinner.hidesWhenStopped = YES;
        
        [self addSubview:refreshLabel];
        [self addSubview:refreshArrow];
        [self addSubview:refreshSpinner];
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


-(void)setReleaseView:(NSString*)text
{
    refreshLabel.text = text;
    refreshArrow.hidden =NO;
    refreshSpinner.hidden =YES;
    refreshArrow.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);    
    [refreshSpinner stopAnimating];
}

-(void)setPullView {
    [self setPullView:@"Pull down to refresh..."];
}

-(void)setPullView:(NSString*)text
{
    refreshLabel.text = text;
    refreshArrow.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    refreshArrow.hidden =NO;
    refreshSpinner.hidden =YES;
    [refreshSpinner stopAnimating];
}

-(void)setUpdating {
    [self setUpdating:@"Updating..."];
}

-(void)setUpdating:(NSString*)text
{
    refreshLabel.text = text;
    refreshArrow.hidden =YES;
    refreshSpinner.hidden =NO;
    [refreshSpinner startAnimating];
}

@end

