//
//  ILocationRepository.h
//  Say
//
//  Created by vnicon on 8/6/12.
//  Copyright (c) 2012 Tech Propulsion Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILocationRepository <NSObject>
@optional
- (void)commitLocationAtPlace:(NSString*)place latitude:(float)latitude longitude:(float)longitude success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;
@end
