

#import "DateHelper.h"

@implementation DateHelper

+(NSString*) notificationDateString:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return  [dateFormatter stringFromDate:date];
}

+(NSDate *) parseRFC3339Date:(NSString *)dateString 
{
    NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
    BOOL success = NO;
    NSDate *theDate = nil;
       
    
    @synchronized(rfc3339TimestampFormatterWithTimeZone)
    {
        [rfc3339TimestampFormatterWithTimeZone setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        
       
        NSError *error = nil; 
        success = [rfc3339TimestampFormatterWithTimeZone getObjectValue:&theDate forString:dateString range:nil error:&error];
          
    }  
    if(success)
        return theDate;
    return [NSDate date];
}


@end
