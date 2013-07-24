

#import "TalkDataFactory.h"
#import "AccountRepository.h"



#import "LocationRepository.h"



@implementation TalkDataFactory


+ (id)sharedInstance{
    static TalkDataFactory *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[TalkDataFactory alloc] init];
    });
    return _shared;
}


- (id<IAccountRepository>)account{
    @synchronized(self){
        if (!_account) {
            _account = [[AccountRepository alloc] init];
        }
    }
    return _account;
}



@end
