

#import "AsyncImageView.h"

#import "UIImage+Ext.h"

@implementation AsyncImageView
@synthesize keepFillSizeImage,fillSize;

- (id) init {
    self = [super init];
    if (self) {
        //defaultImage = [UIImage imageNamed:@"no_image.png"];
        //self.image = defaultImage;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //defaultImage = [UIImage imageNamed:@"no_image.png"];
        //self.image = defaultImage;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)managedObjFailed{
    [loadingWheel stopAnimating];
}

-(void) managedObjReady {
	//NSLog(@"moHandlerReady %@",moHandler);
    UIImage *imageObject ;
    if (keepFillSizeImage) {
        imageObject = [UIImage image:moHandler.managedObj fillSize:fillSize];
    }else {
        imageObject = moHandler.managedObj;
    }
    
	[self setImage:imageObject];
}

- (void) setImageFromURL:(NSString *)imageUrl 
{
    [self setImageFromURL:imageUrl 
              showloading:YES];
}

- (void) setImageFromURL:(NSString *)imageUrl 
             showloading:(BOOL)showloading
{
    if(!imageUrl || [imageUrl isEqual:[NSNull null]])
        return;
    
    UIImage *localImage = [UIImage imageWithContentsOfFile:imageUrl];
    if (localImage) {
        self.image = localImage;
        return;
    }
#if DEBUG
//    NSLog(@"-----imageUrl:  %@",imageUrl);
#endif
    if (imageUrl && ![imageUrl isEqual:[NSNull null]] && [imageUrl length] > 0) {        
        [self clear];
       
        if([imageUrl hasPrefix:@"http"]){
            self.url = [NSURL URLWithString:imageUrl];		
           
            //self.image = [UIImage imageNamed:@"profile_default"];
            if (showloading) [self showLoadingWheel];
            //[self.imageView setImage:[UIImage imageNamed:@"profile_default"]];

            }else {
            self.image = [UIImage imageNamed:imageUrl];
        }
            
    } else {
        self.image = [UIImage imageNamed:@"no-image"];
    }
}

@end