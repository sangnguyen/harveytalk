

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKReverseGeocoder.h>


@interface TalkLocationService : NSObject<CLLocationManagerDelegate,MKReverseGeocoderDelegate>{
    CLLocationManager *locationManager;
    CLLocation        *currentLocation;
    BOOL               isFirstTimeReceiveLocationUpdateEvent;
    NSDate             *lastDetemermineLocationChange;
    // This is used for case we can't detect location information at lat, long address
    // We will use last detected country to display, and it will be updated on next success reversed geocoding
    // We use Country, not State because it rarely changes when user moving
    NSString           *lastDetectedCountry;
    UIAlertView        *_accessDeniedAlert;
}

@property (nonatomic, assign) CGFloat            latitude;
@property (nonatomic, assign) CGFloat            longitude;
@property (nonatomic, retain) NSString*          place;

+ (TalkLocationService*) sharedInstance;
- (void) startLocationUpdate;
- (void) stopLocationUpdate;
- (void) reset;
+ (NSNumber*) calculatorDistance:(float)lat1 lon1: (float)lon1 lat2:(float)lat2 lon2: (float)lon2;
@end
