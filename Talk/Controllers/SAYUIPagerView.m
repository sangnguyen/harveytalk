//
//  SAYPagerController.m
//  Say
//
//  Created by Chinh Nguyen on 7/23/12.
//  Copyright (c) 2012 Tech Propulsion Labs. All rights reserved.
//

#import "SAYPagerController.h"

@interface SAYPagerController (PrivateMethods) 

- (void)loadScrollViewWithPage:(int)page;

- (void)scrollViewDidScroll:(UIScrollView *)sender;

- (int)viewsCount;

@end

@implementation SAYPagerController

@synthesize datasource;

#pragma mark - Initialize methods

- (int)viewsCount {
    if (datasource && [datasource respondsToSelector:@selector(controllersCount)])
        return [datasource controllersCount];
    return 0;
}

- (void)loadView
{
    [super loadView];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self viewsCount] , scrollView.frame.size.height);
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
//    pageControl.numberOfPages = kNumberOfPages;
//    pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    [self setView:scrollView];
}


- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= [self viewsCount])
        return;
    
    if (!datasource || ![datasource respondsToSelector:@selector(controllerAt:)])
        return;
    
    // replace the placeholder if necessary
    UIViewController *controller = [datasource controllerAt:page];
    if ((NSNull *)controller == [NSNull null])
    {
        return;
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

#pragma - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    //if (pageControlUsed)
    //{
    //// do nothing - the scroll was initiated from the page control, not the user dragging
    //return;
    //}
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    pageControlUsed = NO;
}

// Inform child view controllers to load more data
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

@end
