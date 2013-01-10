//
//  LocationService.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 09/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "LocationService.h"

@interface LocationService () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;

@end


@implementation LocationService

@synthesize locationManager;
@synthesize delegate;


#pragma mark - Core lifecycle method
- (id) init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = 30.0;
    }
    return self;
}

#pragma mark - Core public methods implemention
- (void) start {
    [self.locationManager startUpdatingLocation];
}

- (void) stop {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLOcationManagerDelagate implementation

- (void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
    NSLog(@"didUpdateToLocation: %@", newLocation);
    [self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError*)error {
    NSLog(@"didFailWithError: %@", error);
    [self.delegate locationError:error];
}

@end
