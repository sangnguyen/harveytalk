

#import "TalkFollowingTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TalkFollowingTableViewCell
@synthesize labelDateTime,  labelUsername, imageProfile;

- (void)setUpLayoutView
{
    imageProfile.clipsToBounds = YES;
    imageProfile.layer.cornerRadius = 0;
   // labelLocation.textColor = [UIColor colorWithRed:38.0f/255.0 green:34.0f/255.0 blue:98.0f/255.0 alpha:1.0f];
}

@end
