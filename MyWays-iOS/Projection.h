//
//  Projection.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 08/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Projection : NSObject

+ (MWTilePoint) projWithLatitude:(double)latitude andLongitude:(double)longitude;
 
@end
