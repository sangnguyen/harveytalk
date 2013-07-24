

#import "TalkLocationService.h"
#import "TalkLoginMenuController.h"

#define DISTANCE_FILTER 100
#define MINIMUM_TIME_TO_REVERSE_GEOCODE 180 // 3 min

@implementation TalkLocationService
static TalkLocationService * _sharedInstance;
@synthesize latitude, longitude, place;

#pragma mark - Inititalize
+ (id)sharedInstance{
    @synchronized(self){
        if (!_sharedInstance) {
            _sharedInstance = [[TalkLocationService alloc] init];
        }
    }
    return _sharedInstance;
}


- (id) init{
    self = [super init];
    if(self){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        latitude = 1000;
        longitude = 1000;
        isFirstTimeReceiveLocationUpdateEvent = YES;
        lastDetemermineLocationChange= [NSDate date];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = DISTANCE_FILTER;
    }
    return self;
}


#pragma mark- Utilities
// Encapsulate location info to send to notification
- (NSDictionary*) locationInfo{
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            [NSNumber numberWithFloat:latitude],@"latitude",
            [NSNumber numberWithFloat:longitude],@"longitude",
            place,@"place",
            nil];
}
- (void) reset{
    isFirstTimeReceiveLocationUpdateEvent = YES;
    lastDetemermineLocationChange = [NSDate date];
}

- (void)startLocationUpdate
{
    // Dismiss access denied alert view
    if (_accessDeniedAlert) {
        [_accessDeniedAlert dismissWithClickedButtonIndex:0 animated:FALSE];
        _accessDeniedAlert = NULL;
    }
    [self stopLocationUpdate];
    // We use this to pin current user location immediately
    [locationManager startUpdatingLocation];
    // Start monitoring location change by significant of cell tower
    //[locationManager startMonitoringSignificantLocationChanges];
}


- (void)stopLocationUpdate{
    [locationManager stopUpdatingLocation];
    //[locationManager stopMonitoringSignificantLocationChanges];
}


#pragma mark - Location manager delegate
// This delegate method is called if location changed
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // Dismiss access denied alert view
    if (_accessDeniedAlert) {
        [_accessDeniedAlert dismissWithClickedButtonIndex:0 animated:FALSE];
        _accessDeniedAlert = NULL;
    }
    
}


// This delegate method is called if an error occurs in locating your current location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorCodeStr = @"";
    if ([error domain] == kCLErrorDomain)
	{
        switch ([error code])
		{
            case kCLErrorDenied:
            {
                DLog(@"Detect location fail: kCLErrorDenied");
                errorCodeStr = @"Denined Access";
                if (_accessDeniedAlert) return;
                _accessDeniedAlert = [TalkUIAlertView alert:@"" message:@"Please go to Settings to Enable Location Services to Continue Using \"Sparks\""
                    onButtonsDidTouch:^(NSUInteger buttonIndex, UIAlertView *alertView) {
                        _accessDeniedAlert = NULL;
                        [self startLocationUpdate];
                } cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
                break;
            }
            case kCLErrorLocationUnknown:
                DLog(@"Detect location fail: kCLErrorLocationUnknown");
                errorCodeStr = @"Unknown Error";
                // Check for enable location service
                if(([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)||(![CLLocationManager locationServicesEnabled])){
                    _accessDeniedAlert = [TalkUIAlertView alert:@"" message:
                                          [NSString stringWithFormat:@"Please go to Settings to Enable Location Services to Continue Using \"%@\"",
                                            [[UIApplication sharedApplication] applicationName]]
                     onButtonsDidTouch:^(NSUInteger buttonIndex, UIAlertView *alertView) {
                         _accessDeniedAlert = NULL;
                         [self startLocationUpdate];
                     } cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
                }else{
                    // Dismiss access denied alert view
                    if (_accessDeniedAlert) {
                        [_accessDeniedAlert dismissWithClickedButtonIndex:0 animated:FALSE];
                        _accessDeniedAlert = NULL;
                    }
                }
               
                break;
        }
	}
    [self stopLocationUpdate];
}



/*
 Reverse lat,long coordinate to Address using CLLocation
 For iOS5 +
 */
- (void)reverseGeocode:(CLLocation *)location{
    // Check if able to use CLGeocoder in iOS 5+
}


/*
 Reverse lat,long coordinate to Address using  MKReverseGeocoder
 For iOS 4 -
 */
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
}



- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
    DLog(@"Reverse Geocoder Error: %@",error);
    // Callback notification when error
    //[self postLocationUpdateNotification:nil];
   
}


+ (NSNumber*) calculatorDistance:(float)lat1 lon1: (float)lon1 lat2:(float)lat2 lon2: (float)lon2
{
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:lat2 longitude:lon2];
    CLLocationDistance distances = [locA distanceFromLocation:locB];
    return [NSNumber numberWithFloat: distances];
}






@end
