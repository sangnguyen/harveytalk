
#import <Foundation/Foundation.h>

@interface NSData (Ext)

@property(nonatomic,readonly,getter=isEmpty) BOOL empty;

@end


@interface NSData (Base64Helper)

+ (NSData *)dataFromBase64EncodedString:(NSString *)aString;
- (NSString *)base64EncodedString;
- (NSString*) toString;
@end
void *NewBase64Decode(const char *inputBuffer, size_t length, size_t *outputLength);
char *NewBase64Encode(const void *buffer, size_t length, bool separateLines, size_t *outputLength);