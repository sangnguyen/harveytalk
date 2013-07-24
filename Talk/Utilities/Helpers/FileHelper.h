

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject

+(NSURL*) getVideoFileURL:(NSString*)fileName;
+(int) getFileLengthFromPath:(NSString*)filePath;
+(NSData*) readDatafromFile:(NSString*) filePath From:(int) from lenght:(int)lenght;
+ (NSString *) getImagePath:(NSString *)imageName;
+ (NSString*) getProfileImagePath:(NSString *)imageName;
+(void) removeAllVideoWhenLogout;
@end
