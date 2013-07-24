
#import <Foundation/Foundation.h>
#import "JSONHelper.h"
#import "JSON.h"

@interface TalkErrorService : NSObject

+ (NSString *) getErrorMessage:(AFHTTPRequestOperation *)operation;
+ (void) saveToLog: (NSString *) log;
+ (void) tryToPingGoogle;
@end
