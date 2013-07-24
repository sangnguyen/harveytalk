//
//  SAYPagerController.h
//  Say
//
//  Created by Chinh Nguyen on 7/23/12.
//  Copyright (c) 2012 Tech Propulsion Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol SAYPagerControllerDatasource <NSObject>

- (int) controllersCount;

- (UIViewController*) controllerAt:(int)index;

@end

@interface SAYPagerController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    id<SAYPagerControllerDatasource> datasource;
}

@property (nonatomic, retain) id<SAYPagerControllerDatasource> datasource;


@end
