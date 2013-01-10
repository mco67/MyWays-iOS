//
//  TilesSourceCapability.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TilesMatrix : NSObject

@property (nonatomic) int level;
@property (nonatomic) double scaleDenominator;
@property (nonatomic) int topLeftX;
@property (nonatomic) int topLeftY;

@end

    
@interface TilesSourceCapabilities : NSObject

@property (strong, nonatomic) NSArray* tilesMatrixs;

- (id) initWithTileMatrixs:(NSArray*)tilesMatrixs;

@end
