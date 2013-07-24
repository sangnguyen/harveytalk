

#import "LocationRepository.h"

@implementation LocationRepository

- (void)commitLocationAtPlace:(NSString*)place latitude:(float)latitude longitude:(float)longitude success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
       
    if(place.length<=0 && latitude == 0.0 && longitude == 0.0){
        //taluan update do not update if location not found
        return;
    }else {
    }
}

@end
