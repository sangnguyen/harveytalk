

#import "TalkHTTPStatusNet.h"
#import "AFJSONRequestOperation.h"
#import "NSString+SBJSON.h"

#import "AFAmazonS3Client.h"

@implementation TalkHTTPStatusNet


- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        return self;
}

+ (TalkHTTPStatusNet *) statusNetClientWithUserName:(NSString*)userName password:(NSString*)password {
    static TalkHTTPStatusNet *_statusNetClient = nil;
    if (_statusNetClient == NULL) {
        _statusNetClient = [[TalkHTTPStatusNet alloc] initWithBaseURL:[NSURL URLWithString:kTalkStatusNetAPIHost]];
    }
    
    NSString *params =[[[NSString stringWithFormat:@"%@:%@",userName,password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    [_statusNetClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",params]];
    
    return _statusNetClient;
}





@end
