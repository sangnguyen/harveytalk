

#import "TalkPushService.h"

@implementation TalkPushService

static TalkPushService* pushClient = nil;

+ (id)sharedInstance{
    @synchronized(self){
        if (!pushClient) {
            pushClient = [[TalkPushService alloc] init];
        }
    }
    return pushClient;
}



@end
