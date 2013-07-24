

#import <Foundation/Foundation.h>



@interface NSFileManager(Ext)

// Delete File or Directory at given path
+(void) deleteItemAtPath: (NSString *) pathToItem;
// Delete directory at givent path
+(void) deleteDirectory: (NSString *) pathToDirectory;
// Delete file at given path
+(void) deleteFile: (NSString *) pathToFile;
// Copy file 
+(BOOL) copyFrom:(NSString *) srcPath toPath:(NSString *) destPath overwrite: (BOOL) overwrite;
// Delete all file in directory
+(void) deleteAllFilesInDirectory: (NSString *) directory;
// Check if file is exit
+(BOOL) isFileExist: (NSString *) file;

/*
 Collect from:
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 */
+ (NSString *) pathForItemNamed: (NSString *) fname inFolder: (NSString *) path;
+ (NSString *) pathForDocumentNamed: (NSString *) fname;
+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname;

+ (NSArray *) pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path;
+ (NSArray *) pathsForDocumentsMatchingExtension: (NSString *) ext;
+ (NSArray *) pathsForBundleDocumentsMatchingExtension: (NSString *) ext;

+ (NSArray *) filesInFolder: (NSString *) path;
@end
