//
//  TilesSourceCapability.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "TilesSourceCapabilities.h"

@implementation TilesMatrix

- (NSString*) description {
    return [NSString stringWithFormat:@"TilesMatrix level:%d scaleDenominator:%f topLeftCorner:(%d,%d)", self.level, self.scaleDenominator, self.topLeftX, self.topLeftY];
}

@end


@implementation TilesSourceCapabilities

- (id) initWithTileMatrixs:(NSArray*)tilesMatrixs {
    if (self = [super init]) {
        self.tilesMatrixs = tilesMatrixs;
    }
    return self;
}

- (NSString*) description {
    NSMutableString* descriptionString = [[NSMutableString alloc] initWithCapacity:0];
    [descriptionString appendString:@"TileSourceCapabilities:\n"];
    for (TilesMatrix* tileMatrix in self.tilesMatrixs)
        [descriptionString appendFormat:@"  %@\n", tileMatrix];
    return descriptionString;
}

@end
