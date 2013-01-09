//
//  ProjectionTests.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 08/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "ProjectionTests.h"
#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>



@implementation ProjectionTests 


- (void) setUp {
[super setUp];
}

- (void) tearDown {
    [super tearDown];
}

- (void) testExample {
    NSLog(@"--> Starting testExample");
    LocationService* locationService = [[LocationService alloc] init];
    [locationService start];
    [NSThread sleepForTimeInterval:3];
}
 
@end
