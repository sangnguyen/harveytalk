

#import "TalkBaseController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewAnnotation.h"
@interface TalkMapController : TalkBaseController {
    NSString *place;
    NSNumber *longitude;
    NSNumber *latitude;
    NSString *profileName;
    MKMapView* mapView;
}

-(id)initWithPlace:(NSString*)place
         longitude:(NSNumber*)longitude
          latitude:(NSNumber*)latitude
       profileName:(NSString*)name;

@end
