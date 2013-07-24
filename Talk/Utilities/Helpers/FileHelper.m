
#import "FileHelper.h"


@implementation FileHelper


+(void) checkVideoDirectory{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:VIDEO_FOLDER];
    BOOL yes = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&yes]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+(void) checkImageDirectory{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:IMAGE_FOLDER];
    BOOL yes = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&yes]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (NSString *) getImagePath:(NSString *)imageName{
    [self checkImageDirectory];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [[documentsDirectory stringByAppendingPathComponent:VIDEO_FOLDER]
                      stringByAppendingPathComponent:imageName];
    return path;
}

+ (NSString*) getProfileImagePath:(NSString *)imageName{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    BOOL yes = YES;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:IMAGE_PROFILE_FOLDER];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&yes]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:imageName];
    return path;
}

+(NSURL*) getVideoFileURL:(NSString*)fileName{
    [self checkVideoDirectory];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [[documentsDirectory stringByAppendingPathComponent:VIDEO_FOLDER] stringByAppendingPathComponent:fileName];
    return [NSURL URLWithString:path];
}

//remove file when logout
+(void) removeAllVideoWhenLogout
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:VIDEO_FOLDER];
    BOOL yes = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&yes]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        
    }
}

+(int) getFileLengthFromPath:(NSString*)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary* fileAttributes = [fileManager attributesOfItemAtPath:filePath error:nil];
    if (fileAttributes != nil) {
        return  [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return 0;
}

+(NSData*) readDatafromFile:(NSString*) filePath From:(int) from lenght:(int)lenght{
    NSFileHandle *file;
    NSData *dataBuffer;
    
    file = [NSFileHandle fileHandleForReadingAtPath: filePath];
    
//    if (file == nil)
//        NSLog(@"Failed to open file");
    
    [file seekToFileOffset: from];
    
    dataBuffer = [file readDataOfLength: lenght];
    
    [file closeFile];
    return dataBuffer;
}

@end
