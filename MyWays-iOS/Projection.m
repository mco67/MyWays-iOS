//
//  Projection.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 08/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "Projection.h"
#import <math.h>

#define EQUAT_RADIUS 6378137.0

@implementation Projection

+ (MWTilePoint) projWithLatitude:(double)latitude andLongitude:(double)longitude {

    double latRadian = latitude * M_PI/180;
    double longRadian = longitude * M_PI/180;
     
    double X = EQUAT_RADIUS * longRadian;
    double Y = EQUAT_RADIUS * log(tan(latRadian/2 + M_PI_4));
    

    int level = 18;
    
    double tileRes = 256;
    double pixelPitch = 0.28;
    double scaleDenominator = 2132.7295838497840572;
    double tileBorderWidth = pixelPitch*scaleDenominator*tileRes/1000.0;
    
    double topLeftCornerX = -20037508.0;
    double topLeftCornerY = 20037508.0;
    
    double x = X - topLeftCornerX;
    double y = topLeftCornerY - Y;

    int TILEROW = (int)(y/tileBorderWidth);
    int TILECOL = (int)(x/tileBorderWidth);
    
    return MWTilePointMake(TILEROW, TILECOL);
}

@end
