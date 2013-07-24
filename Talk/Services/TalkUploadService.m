

#import "TalkUploadService.h"
#import "AFHTTPRequestOperation.h"

#import "TalkXMPPService.h"
#import "TalkHTTPService.h"
#import "SBJSON.h"
#import "JSONHelper.h"




@implementation TalkUploadService
static TalkUploadService * _sharedInstance;
@synthesize awsArray = _awsArray;

- (id) init{
    self = [super init];
    if(self){
        _awsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id)sharedInstance{
    @synchronized(self){
        if (!_sharedInstance) {
            _sharedInstance = [[TalkUploadService alloc] init];
        }
    }
    return _sharedInstance;
}


@end
