


/* Macro use for NO ARC */
#if __has_feature(objc_arc)
#define SAFE_RELEASE(obj) 
#define SAFE_TIMER_RELEASE(obj) 
#else
#define SAFE_RELEASE(obj) ([obj release], obj = nil)
#define SAFE_TIMER_RELEASE(obj) ([obj invalidate], [obj release], obj = nil)
#endif

/* ARC macros */
#if !defined(__clang__) || __clang_major__ < 3
#ifndef __bridge
#define __bridge
#endif

#ifndef __bridge_retain
#define __bridge_retain
#endif

#ifndef __bridge_retained
#define __bridge_retained
#endif

#ifndef __autoreleasing
#define __autoreleasing
#endif

#ifndef __strong
#define __strong
#endif

#ifndef __unsafe_unretained
#define __unsafe_unretained
#endif

#ifndef __weak
#define __weak
#endif
#endif

#if __has_feature(objc_arc)
#define SAFE_ARC_PROP_RETAIN strong
#define SAFE_ARC_RETAIN(x) (x)
#define SAFE_ARC_RELEASE(x)
#define SAFE_ARC_AUTORELEASE(x) (x)
#define SAFE_ARC_BLOCK_COPY(x) (x)
#define SAFE_ARC_BLOCK_RELEASE(x)
#define SAFE_ARC_SUPER_DEALLOC()
#define SAFE_ARC_AUTORELEASE_POOL_START() @autoreleasepool {
#define SAFE_ARC_AUTORELEASE_POOL_END() }
#else
#define SAFE_ARC_PROP_RETAIN retain
#define SAFE_ARC_RETAIN(x) ([(x) retain])
#define SAFE_ARC_RELEASE(x) ([(x) release])
#define SAFE_ARC_AUTORELEASE(x) ([(x) autorelease])
#define SAFE_ARC_BLOCK_COPY(x) (Block_copy(x))
#define SAFE_ARC_BLOCK_RELEASE(x) (Block_release(x))
#define SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
#define SAFE_ARC_AUTORELEASE_POOL_START() NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#define SAFE_ARC_AUTORELEASE_POOL_END() [pool release];
#endif


/// DEBU macro
#ifdef DEBUG
#define MCRelease(x) [x release], x = nil
#define DLog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#else
#define MCRelease(x) [x release], x = nil
#define DLog(...) do { } while (0)
#ifndef NS_BLOCK_ASSERTIONS
#define NS_BLOCK_ASSERTIONS
#endif
#define ALog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#endif


/// Import common categories
#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "NSString+Ext.h"
#import "NSData+Ext.h"
#import "NSDate+Ext.h"
#import "UIAlertView+BlockExtensions.h"
#import "NSFileManager+Ext.h"
#import "NSURL+Ext.h"
#import "NSObject+Ext.h"
#import "NSMutableArray+Stack.h"
#import "UIAlertView+Ext.h"
#import "UIDevice+Ext.h"
#import "UIApplication+Ext.h"
#import "UIColor+Ext.h"
#import "UIImage+Ext.h"
#import "UIView+Ext.h"
#import "UIBarButtonItem+Ext.h"
#import "MBProgressHUD.h"
#import "Guid.h"
#import "Functions.h"
#import "UIAlertView+Modal.h"
#endif



/// Shor selector
#define SEL(x) @selector(x)
#define Localize(key) (NSLocalizedString((key), nil))


/// Common UI Constants
#define SCREEN_WIDTH        [UIScreen mainScreen].applicationFrame.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].applicationFrame.size.height

#define HEIGHT_OF_STATUS_BAR 20
#define HEIGHT_OF_TOOLBAR 44
#define HEIGHT_OF_TABLE_CELL 44
#define HEIGHT_OF_TAB_BAR 49
#define HEIGHT_OF_SEARCH_BAR 44
#define HEIGHT_OF_NAVIGATION_BAR 44
#define HEIGHT_OF_TEXTFIELD 31
#define HEIGHT_OF_PICKER 216
#define HEIGHT_OF_KEYBOARD 216
#define HEIGHT_OF_SEGMENTED_CONTROL 43
#define HEIGHT_OF_SEGMENTED_CONTROL_BAR 29
#define HEIGHT_OF_SEGMENTED_CONTROL_BEZELED 40
#define HEIGHT_OF_SWITCH 27
#define HEIGHT_OF_SLIDER 22
#define HEIGHT_OF_PROGRESS_BAR 9
#define HEIGHT_OF_PAGE_CONTROL 36
#define HEIGHT_OF_BUTTON 37

//profile image upload

#define kPhotoUploadRetryTime   1

#define kProfileBigImageUploadW 320
#define kProfileBigImageUploadH 320
#define kProfileBigImageUploadPosX 0
#define kProfileBigImageUploadPosY 60

#define kProfileSmallImageUploadW 225
#define kProfileSmallImageUploadH 225
#define kProfileSmallImageUploadPosX 48.0f
#define kProfileSmallImageUploadPosY 108

//#define kProfileMidImageUploadW 152
//#define kProfileMidImageUploadH 75
//#define kProfileMidImageUploadPosX 84
//#define kProfileMidImageUploadPosY 183
//
//#define kProfileLargeImageUploadW 229
//#define kProfileLargeImageUploadH 75
//#define kProfileLargeImageUploadPosX 46
//#define kProfileLargeImageUploadPosY 183

#define kProfileDoubleImageUploadW 290
#define kProfileDoubleImageUploadH 142
#define kProfileDoubleImageUploadPosX 15
#define kProfileDoubleImageUploadPosY 90

#define RESIZE_TAKEPHOTO_WIDTH 384
#define RESIZE_TAKEPHOTO_HEIGHT 512

#define kProfilePhotoUploadViewW 320
#define kProfilePhotoUploadViewH 320

#define kCornerRadiusForFullImage 10.0f
#define kCornerRadiusForViewPanel   8.0f
#define kCornerRadiusForViewInsideViewPanel   5.0f

#define kFontSizeButtonGuidelines 14.0f
#define kFontSizeLabelGuidelines 13.0f


// Frame type for upload image
typedef enum {
    Small,
    Midium,
    Large,
    Big,
    Double
} UploadFrameType;

typedef enum GALLERY_TYPE
{
    FEATURE_PHOTO = 1,
    PUBLIC_PHOTO,
    PRIVATE_PHOTO,
    PRIVATE_VIDEO
}GALLERY_TYPE;

