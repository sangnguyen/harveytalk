

#import "DBHelper.h"
#import "sqlite3.h"

@implementation DBHelper
static DBHelper *instance = nil;
+ (DBHelper *)shared
{
    if (instance == nil) {
        instance = [[DBHelper alloc] init];
    }
    return instance;
}
- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void) initDB
{
    sqlite3 *database = nil;
    sqlite3_stmt *statement = nil;
    int result = sqlite3_open([[self getDBPath] UTF8String], &database);    
    if(result != SQLITE_OK)
    {
        sqlite3_close(database);
        UIAlertView *view = [[UIAlertView alloc]
                             initWithTitle: @"Database Error"
                             message: @"Failed to open database."
                             delegate: self
                             cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [view show];
        //[view autorelease];
        return;
    }
    else
    {
       
        /* Create HISTORY table */
        NSString *createHistoryTable = @"CREATE TABLE IF NOT EXISTS HISTORY" 
        "("
        "ID INTEGER 						PRIMARY KEY AUTOINCREMENT,"
        "MSG_TYPE 							VARCHAR(255)," 
        "MSG_CONTENT                        TEXT," 
        "MSG_SENDERID                       VARCHAR(255),"
        "MSG_FROM                           VARCHAR(255),"
        "MSG_RECEIVERID                      VARCHAR(255),"
        "MSG_TO                             VARCHAR(255),"
        "MSG_DATE                           TEXT,"      
        "MSG_TAG                            VARCHAR(255),"
        "MSG_IMAGEURL                       TEXT,"
        "MSG_THUMBURL                       TEXT,"
        "MSG_THUMB                          TEXT,"
        "MSG_USERNAME                       VARCHAR(255),"    
        "MSG_PROFILEID                     VARCHAR(255)"
        ")";
        if(sqlite3_prepare_v2(database, [createHistoryTable UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            NSLog(@"DBHelper - Error preparing create statement for MESSAGE table: %s", sqlite3_errmsg(database));
        }
        else 
        {
            if(sqlite3_step(statement) != SQLITE_DONE)
            {
                NSLog(@"DBHelper - Error create MESSAGE table: %s", sqlite3_errmsg(database));
            } 
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    } 
 
}

//===================================

- (NSString *) getDBPath {	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"Say.sqlite"];
}

@end
