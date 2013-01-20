//
//  TilesSource.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TilesSourceCapabilities.h"

typedef struct {
    int tileRow;
    int tileCol;
} TileCoordinates;

static inline TileCoordinates MWTileCoordinatesMake(int tileRow, int tileCol) {
    TileCoordinates p; p.tileRow = tileRow; p.tileCol = tileCol; return p;
}

@interface TilesSource : NSObject

@property (strong, nonatomic) TilesSourceCapabilities* capabilities;

- (TileCoordinates) getTileCoordinatesForLevel:(int)level andLatitudeInDegrees:(double)latitudeInDegrees andLongitudeInDegrees:(double)longitudeInDegrees;

- (UIImage*) getTileImageForLevel:(int)level andTileCoordinates:(TileCoordinates)tileCoordinates;

@end
