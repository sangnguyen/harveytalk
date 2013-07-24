

#import <UIKit/UIKit.h>
#import "HJManagedImageV.h"
#import "HJObjManager.h"

@interface AsyncImageView : HJManagedImageV {
    BOOL keepFillSizeImage;
}

- (void) setImageFromURL:(NSString *)imageUrl;
- (void) setImageFromURL:(NSString *)imageUrl
             showloading:(BOOL)showloading;
/*
- (void) setImageByCategoryPinName:(NSString*)name;
- (void) setImageByCategoryName:(NSString*)name;
- (void) setImageByCategory:(NSString*)name;
*/
@property (nonatomic,assign) BOOL keepFillSizeImage;
@property (nonatomic,assign) CGSize fillSize;
@end