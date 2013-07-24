

#import <Foundation/Foundation.h>
#import "TalkAWSService.h"

@interface TalkUploadService : NSObject<TalkAWSServiceDelegate>{
    
}
+ (TalkUploadService*) sharedInstance;

@property (nonatomic, retain) NSMutableArray *awsArray;

@end
