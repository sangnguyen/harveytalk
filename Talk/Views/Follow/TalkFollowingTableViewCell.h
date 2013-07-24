
#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface TalkFollowingTableViewCell : UITableViewCell{

}
@property (nonatomic, retain) IBOutlet AsyncImageView *imageProfile;
@property (nonatomic, retain) IBOutlet UILabel *labelUsername;
//@property (nonatomic, retain) IBOutlet UILabel *labelLocation;
@property (nonatomic, retain) IBOutlet UILabel *labelDateTime;

- (void)setUpLayoutView;

@end
