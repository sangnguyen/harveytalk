
#import <Foundation/Foundation.h>
@interface TalkDataFactory : NSObject{
    id<IAccountRepository> _account;
   
   
   
    id<ILocationRepository> _location;
    
}
+ (id) sharedInstance;
@property(readonly,strong,getter=account) id<IAccountRepository> account;



@property(readonly,strong,getter=location) id<ILocationRepository> location;

@end
