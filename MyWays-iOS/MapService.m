//
//  MapService.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "MapService.h"
#import "TilesSource.h"
#import "TilesSourceCapabilities.h"

@interface MapService ()

@property (strong, nonatomic) TilesSource* tilesSource;

@end


@implementation MapService

@synthesize tilesSource;

- (id) initWithTilesSource:(TilesSource*)tileSource {
    if (self = [super init]) {
        self.tilesSource = tileSource;
        NSLog(@"%@", self.tilesSource.capabilities);
    }
    return self;
}

- (UIImage*) getTileImageForLevel:(int)level andLatitudeInDegrees:(double)latitudeInDegrees andLongitudeInDegrees:(double)longitudeInDegrees {
    return [tilesSource getTileImageForLevel:level andLatitudeInDegrees:latitudeInDegrees andLongitudeInDegrees:longitudeInDegrees];
}

@end
