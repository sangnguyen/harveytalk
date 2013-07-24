
#import "TalkMapController.h"

@interface TalkMapController(Private)

-(void)setMapCenter:(CLLocationCoordinate2D)location 
         withRadius:(CLLocationDegrees)radius;

@end

@implementation TalkMapController

-(id)initWithPlace:(NSString*)p
         longitude:(NSNumber*)lon
          latitude:(NSNumber*)lat
       profileName:(NSString*)name
{
    self = [super init];
    if (self) {
        place = p;
        latitude = lat;
        longitude = lon;
        profileName = name;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Map";

        
    if (!mapView)
    {
        // Crate map view
        mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
        mapView.showsUserLocation = YES;
        mapView.mapType = MKMapTypeStandard;
        [self.view addSubview:mapView];
        if(place.length > 0)
        {
            CLLocationCoordinate2D location;
            location.latitude	=	[latitude floatValue];
            location.longitude	=	[longitude floatValue];
            [self setMapCenter:location withRadius:0.02f]; //0.02 ~ 1.7 mile
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Utilities

- (void) setMapCenter:(CLLocationCoordinate2D)location
           withRadius:(CLLocationDegrees)radius
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=radius;
    span.longitudeDelta=radius;
    region.span=span;
    region.center=location;
    
    if (location.latitude >= -90.0f && location.latitude <= 90.0f
        && location.longitude >= -180.0f && location.longitude <= 180.0f)
    {
        [mapView setRegion:region animated:TRUE];

    }
    else
    {
        [TalkUIAlertView alert:@"Invalid Region" message:@"The location is invalid."];
    }
    
    
}


@end
