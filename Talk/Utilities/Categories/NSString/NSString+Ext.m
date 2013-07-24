

#import "NSString+Ext.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (Ext)

#pragma mark - Convertor methods
// TODO: Add other methods, specifically SHA1

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString*)toMD5 {
	const char* string = [self UTF8String];
	unsigned char result[16];
	CC_MD5(string, strlen(string), result);
	NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
	return [hash lowercaseString];
}

- (int) toInteger{
    return [self intValue];
}


#pragma mark - Constructor method
+ (NSString *)format:(NSString *)patterns values:(va_list)values{
    return [NSString stringWithFormat:patterns,values];
}


#pragma mark - Utility methods
- (BOOL)contains:(NSString*)string {
	return [self contains:string options:NSCaseInsensitiveSearch];
}

- (BOOL)contains:(NSString*)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

- (NSArray *)split:(NSString *)string{
    return [self componentsSeparatedByString: string];
}

- (void) trim{
    [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)startWith:(NSString *)string options:(NSStringCompareOptions)options{
    if ([self length] < [string length]) return NO;
    NSString *beginning = [self substringToIndex:[string length]];
    return ([beginning compare:string options:options] == NSOrderedSame);
}

- (BOOL)endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options {
    if ([self length] < [endsWith length]) return NO;
    NSString *lastString = [self substringFromIndex:[self length] - [endsWith length]];
    return ([lastString compare:endsWith options:options] == NSOrderedSame);
}

- (BOOL)startWith:(NSString *)string{
    return [self startWith:string options:NSLiteralSearch];
}
- (BOOL)endsWith:(NSString *)string{
    return [self endsWith:string options:NSLiteralSearch];
}

- (int)indexOf:(NSString *)string{
    return [self rangeOfString:string].location;
}
- (int)lastIndexOf:(NSString *)string{
    return [self rangeOfString:string options:NSBackwardsSearch].location;
}

- (NSString*) replace:(NSString *)replace with:(NSString *)with{
    return [self stringByReplacingOccurrencesOfString:replace withString:with];
}

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}

- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingLeadingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1]; // non-inclusive
}

- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingTrailingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)append:(NSString *)append{
    return [self stringByAppendingString:append];
}
#pragma mark - Check method
- (BOOL) isValidURL{
    return [NSURL URLWithString:self] != NULL;
}

- (BOOL)isValidEmail{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *validator = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", regex];
	return [validator evaluateWithObject: self];
}


- (BOOL) isEmpty{
    return !self || [self length] == 0;
}


#pragma mark - Encode / Decode
- (NSString *)encodeWithUTF8{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*) urlEncode{
    return (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
}

- (NSString*) encodeEmojiString{
    NSData *data = [self dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSString*) decodeEmojiString{
     NSData *decode= [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [[NSString alloc] initWithData:decode encoding:NSNonLossyASCIIStringEncoding];
}
+(BOOL) validateEmail: (NSString *) email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}

+ (NSString *)jidWithName:(NSString *)name{
    NSString *jid ;
    if ([@"@" rangeOfString:name].location == NSNotFound) {
        jid = [name stringByAppendingString:@""];//TODO
        return jid;
    }
    return name;
}


+ (NSString *) getStringDateFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (NSString *) getStringDateWithTimeZone:(NSString*)timeStamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate* dateTime      = [dateFormatter dateFromString:timeStamp];
    long timezoneoffset = ([[NSTimeZone systemTimeZone] secondsFromGMT] + 180);//add late 3 minute
    dateTime      = [dateTime dateByAddingTimeInterval:timezoneoffset];
    
    return [self getStringDateFromDate:dateTime];
}

- (NSDate *) dateFromString
{
    //set format date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//yyyy-MM-dd HH:mm:ss +0000
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter dateFromString:self];
}

+ (NSString *) stringFromNumberArray: (NSArray *) array
{
    NSMutableString * str = [NSMutableString string];
    
    for(NSNumber * number in array)
    {
        if(![number isKindOfClass:[NSNumber class]]) continue;
        [str appendFormat:@"%d,", number.intValue];
    }
    
    if(str.length >0) [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
    
    return str;
}

- (NSString *) URLEncodedString {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
@end
