//
//  MapViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MapViewController.h"
#import "MapView.h"
#import "LocationService.h"
#import "IGNTilesSource.h"
#import "MainViewController.h"

@interface MapViewController () <LocationServiceDelegate>

@property (weak, nonatomic) IBOutlet MapView* mapView;
@property (strong, nonatomic) LocationService* locationService;

- (IBAction) onDoneButtonTap:(id)sender;

@end


@implementation MapViewController

@synthesize mapView;
@synthesize locationService;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {}
    return self;
}

- (void) viewDidLoad {
    
    // Create the TileSource
    TilesSource* tilesSource = [[IGNTilesSource alloc] init];
    
    // Associate tileSource to mapView
    self.mapView.tilesSource = tilesSource;
    
    [self.mapView reload];
    
    // Create the locationService
    self.locationService = [[LocationService alloc] init];
    self.locationService.delegate = self;
    //[self.locationService start];
    
}

- (void) locationUpdate:(CLLocation *)location {
    //[self.locationService stop];
    
    double latitudeInDegree = location.coordinate.latitude;
    double longitudeInDegree = location.coordinate.longitude;
}


- (void) didReceiveMemoryWarning {
    
}

- (IBAction) onDoneButtonTap:(id)sender {
    [((MainViewController*)self.presentingViewController) dismissViewController];
}


@end
