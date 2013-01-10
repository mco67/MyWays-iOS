//
//  MapService.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TilesSource.h"

@interface MapService : NSObject

- (id) initWithTilesSource:(TilesSource*)tileSource;
- (UIImage*) getTileImageForLevel:(int)level andLatitudeInDegrees:(double)latitudeInDegrees andLongitudeInDegrees:(double)longitudeInDegrees;


@end
