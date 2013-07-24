
#import <Foundation/Foundation.h>

@interface NSString (Ext)

#pragma mark - Constructors methods
+ (NSString*) format:(NSString*)patterns values:(va_list)values;



#pragma mark - Utility methods

- (BOOL) contains:(NSString*)string;

- (BOOL) contains:(NSString*)string options:(NSStringCompareOptions)options;

- (NSArray*) split:(NSString*)string;

- (void) trim;

- (BOOL) startWith:(NSString*)string;

- (BOOL) endsWith:(NSString*)string;

- (BOOL) startWith:(NSString *)endsWith options:(NSStringCompareOptions)options;

- (BOOL) endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options;

- (int) indexOf:(NSString*)string;

- (int) lastIndexOf:(NSString*)string;

- (NSString*) replace:(NSString*)replace with:(NSString*)with;
- (NSString*) append:(NSString*)append;
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

#pragma mark - Encode / Decode
- (NSString*) encodeWithUTF8;
- (NSString*) encodeEmojiString;
- (NSString*) decodeEmojiString;
- (NSString*) urlEncode;
#pragma mark - Check methods
- (BOOL) isValidEmail;
- (BOOL) isValidURL;
- (BOOL) isEmpty;

#pragma mark - Convertor methods
- (NSString*) toMD5;
- (int)  toInteger;

+ (BOOL) validateEmail: (NSString *) email;

+ (NSString *)jidWithName:(NSString *)name;

+ (NSString *) getStringDateFromDate:(NSDate*)date;

+ (NSString *) getStringDateWithTimeZone:(NSString*)timeStamp;

- (NSDate *) dateFromString;
+ (NSString *) stringFromNumberArray: (NSArray *) array;
- (NSString *) URLEncodedString;
@end
