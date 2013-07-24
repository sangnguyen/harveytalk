
#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+(NSString*) notificationDateString:(NSDate*)date;
+(NSDate*) parseRFC3339Date:(NSString *)dateString;

@end
