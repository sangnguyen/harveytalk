

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
@interface MapViewAnnotation : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString * title;
}
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *  title;

@end
