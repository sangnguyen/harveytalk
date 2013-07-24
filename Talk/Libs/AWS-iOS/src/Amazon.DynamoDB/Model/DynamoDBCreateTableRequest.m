/*
 * Copyright 2010-2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import "DynamoDBCreateTableRequest.h"


@implementation DynamoDBCreateTableRequest

@synthesize tableName;
@synthesize keySchema;
@synthesize provisionedThroughput;


-(id)init
{
    if (self = [super init]) {
        tableName             = nil;
        keySchema             = nil;
        provisionedThroughput = nil;
    }

    return self;
}

-(id)initWithTableName:(NSString *)theTableName andKeySchema:(DynamoDBKeySchema *)theKeySchema
{
    if (self = [self init]) {
        self.tableName = theTableName;
        self.keySchema = theKeySchema;
    }

    return self;
}

-(id)initWithTableName:(NSString *)theTableName andKeySchema:(DynamoDBKeySchema *)theKeySchema andProvisionedThroughput:(DynamoDBProvisionedThroughput *)theProvisionedThroughput
{
    if (self = [self init]) {
        self.tableName             = theTableName;
        self.keySchema             = theKeySchema;
        self.provisionedThroughput = theProvisionedThroughput;
    }

    return self;
}



-(NSString *)description
{
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:256];

    [buffer appendString:@"{"];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"TableName: %@,", tableName] autorelease]];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"KeySchema: %@,", keySchema] autorelease]];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"ProvisionedThroughput: %@,", provisionedThroughput] autorelease]];
    [buffer appendString:[super description]];
    [buffer appendString:@"}"];

    return [buffer autorelease];
}



-(void)dealloc
{
    [tableName release];
    [keySchema release];
    [provisionedThroughput release];

    [super dealloc];
}


@end
