//
//  MapViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MapViewController.h"
#import "MapService.h"
#import "LocationService.h"
#import "IGNTilesSource.h"



@interface MapViewController () <LocationServiceDelegate>

@property (weak, nonatomic) ViewController* mainViewController;
@property (strong, nonatomic) MapService* mapService;
@property (strong, nonatomic) LocationService* locationService;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* doneButton;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UILabel* label;

- (IBAction) onDoneButtonTap:(id)sender;

@end

@implementation MapViewController

@synthesize view;
@synthesize mainViewController;

- (id)initWithParentViewController:(ViewController*)viewController {
    if (self = [super init]) {
        
        // Store injected parameters
        self.mainViewController = viewController;
        
        // Load the XIB
        [[NSBundle mainBundle] loadNibNamed:@"MapViewController" owner:self options:nil];
        
        // Create the MapService
        TilesSource* tileSource = [[IGNTilesSource alloc] init];
        self.mapService = [[MapService alloc] initWithTilesSource:tileSource];
        
        // Create the locationService
        self.locationService = [[LocationService alloc] init];
        self.locationService.delegate = self;
        [self.locationService start];
    }
    return self;
}

- (void) locationUpdate:(CLLocation *)location {
    //[self.locationService stop];
    
    double latitudeInDegree = location.coordinate.latitude;
    double longitudeInDegree = location.coordinate.longitude;
    
    self.imageView.image = [self.mapService getTileImageForLevel:17 andLatitudeInDegrees:latitudeInDegree andLongitudeInDegrees:longitudeInDegree];
}







- (void) didReceiveMemoryWarning {
    
}

- (IBAction) onDoneButtonTap:(id)sender {
    [self.mainViewController hideModalView];
}


@end
