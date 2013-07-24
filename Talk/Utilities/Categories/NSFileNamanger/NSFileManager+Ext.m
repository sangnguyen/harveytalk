

#import "NSFileManager+Ext.h"




@implementation NSFileManager(Ext)


+(void) deleteItemAtPath: (NSString *) pathToItem
{
    BOOL isDirectory;
	if([[NSFileManager defaultManager] fileExistsAtPath:pathToItem isDirectory:&isDirectory])
    {
        if(isDirectory)
        {
            [self deleteDirectory:pathToItem];
        }
        else
        {
            [self deleteFile:pathToItem];
        }
    }
}

+(void) deleteFile: (NSString *) pathToFile
{
	BOOL isDirectory;
	NSFileManager *fileManager	=	[NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:pathToFile isDirectory:&isDirectory] && !isDirectory)
	{
		[fileManager removeItemAtPath:pathToFile		error:nil];
	}
}

+(void) deleteDirectory: (NSString *) pathToDirectory
{
    BOOL isDirectory;
	NSFileManager *fileManager	=	[NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:pathToDirectory isDirectory:&isDirectory])
	{
		if(isDirectory)
        {
            for(NSString * item in [fileManager contentsOfDirectoryAtPath:pathToDirectory error:nil])
            {
                [self deleteItemAtPath:item];
            }
            
            [fileManager removeItemAtPath:pathToDirectory error:nil];
        }
        else
        {
            [self deleteFile:pathToDirectory];
        }
	}
}

+(BOOL) copyFrom:(NSString *) srcPath toPath:(NSString *) destPath overwrite: (BOOL) overwrite
{
	NSFileManager *fileManager	=	[NSFileManager defaultManager];
	if(!srcPath || ![fileManager fileExistsAtPath:srcPath])
	{		
		NSLog(@"source file %@ doesn't exists", srcPath);
		return NO;
	}
	
    
	
	if(overwrite)
	{
		[fileManager removeItemAtPath:destPath error:nil];
	}
	else 
	{
		if(!destPath || [fileManager fileExistsAtPath:destPath])
		{
			NSLog(@"destination file %@ already exists", destPath);
			return NO;
		}
	}
    
	
	NSError *error;
	if(![fileManager copyItemAtPath:srcPath toPath:destPath error:&error])
	{
		NSLog(@"Unable to copy image from path:%@ to path:%@ error:%@", srcPath, destPath, [error localizedDescription]); 
		return NO;
	}
	
	return YES;
}

+(void) deleteAllFilesInDirectory:(NSString *)directory
{
	NSFileManager *fileManager	=	[NSFileManager defaultManager];
	NSArray *files	=	[fileManager contentsOfDirectoryAtPath:directory error:nil];
	for(NSString *file in files)
	{
		[fileManager removeItemAtPath:[directory stringByAppendingPathComponent:file]		error:nil];
	}
}

+(BOOL) isFileExist: (NSString *) file
{
    if(!file)
        return NO;
    
	BOOL isDirectory;
	return [[NSFileManager defaultManager] fileExistsAtPath:file isDirectory:&isDirectory] && !isDirectory;
}



+ (NSString *) pathForItemNamed: (NSString *) fname inFolder: (NSString *) path
{
	NSString *file;
	NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
	while (file = [dirEnum nextObject]) 
		if ([[file lastPathComponent] isEqualToString:fname]) 
			return [path stringByAppendingPathComponent:file];
	return nil;
}

+ (NSString *) pathForDocumentNamed: (NSString *) fname 
{
	return [NSFileManager pathForItemNamed:fname inFolder:DOCUMENTS_DIR()];
}

+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname
{
	return [NSFileManager pathForItemNamed:fname inFolder:LIBRARY_DIR()];
}

+ (NSArray *) filesInFolder: (NSString *) path
{
	NSString *file;
	NSMutableArray *results = [NSMutableArray array];
	NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
	while (file = [dirEnum nextObject])
	{
		BOOL isDir;
		[[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:file] isDirectory: &isDir];
		if (!isDir) [results addObject:file];
	}
	return results;
}

// Case insensitive compare, with deep enumeration
+ (NSArray *) pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path
{
	NSString *file;
	NSMutableArray *results = [NSMutableArray array];
	NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
	while (file = [dirEnum nextObject]) 
		if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame)
			[results addObject:[path stringByAppendingPathComponent:file]];
	return results;
}

+ (NSArray *) pathsForDocumentsMatchingExtension: (NSString *) ext
{
	return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:DOCUMENTS_DIR()];
}

// Case insensitive compare
+ (NSArray *) pathsForBundleDocumentsMatchingExtension: (NSString *) ext
{
	return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:BUNDLE_DIR()];
}
@end
