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

#import "EC2CreateImageRequestMarshaller.h"

@implementation EC2CreateImageRequestMarshaller

+(AmazonServiceRequest *)createRequest:(EC2CreateImageRequest *)createImageRequest
{
    AmazonServiceRequest *request = [[EC2Request alloc] init];

    [request setParameterValue:@"CreateImage"           forKey:@"Action"];
    [request setParameterValue:@"2012-04-01"   forKey:@"Version"];

    [request setDelegate:[createImageRequest delegate]];
    [request setCredentials:[createImageRequest credentials]];
    [request setEndpoint:[createImageRequest requestEndpoint]];
    [request setRequestTag:[createImageRequest requestTag]];

    if (createImageRequest != nil) {
        if (createImageRequest.instanceId != nil) {
            [request setParameterValue:[NSString stringWithFormat:@"%@", createImageRequest.instanceId] forKey:[NSString stringWithFormat:@"%@", @"InstanceId"]];
        }
    }
    if (createImageRequest != nil) {
        if (createImageRequest.name != nil) {
            [request setParameterValue:[NSString stringWithFormat:@"%@", createImageRequest.name] forKey:[NSString stringWithFormat:@"%@", @"Name"]];
        }
    }
    if (createImageRequest != nil) {
        if (createImageRequest.descriptionValue != nil) {
            [request setParameterValue:[NSString stringWithFormat:@"%@", createImageRequest.descriptionValue] forKey:[NSString stringWithFormat:@"%@", @"Description"]];
        }
    }
    if (createImageRequest != nil) {
        if (createImageRequest.noRebootIsSet) {
            [request setParameterValue:(createImageRequest.noReboot ? @"true":@"false") forKey:[NSString stringWithFormat:@"%@", @"NoReboot"]];
        }
    }


    return [request autorelease];
}

@end

