//
//  LocationService.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 09/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationServiceDelegate

@required
- (void)locationUpdate:(CLLocation*)location;
- (void)locationError:(NSError*)error;

@end


@interface LocationService : NSObject

@property (weak, nonatomic) id<LocationServiceDelegate> delegate;

- (void) start;
- (void) stop;

@end
