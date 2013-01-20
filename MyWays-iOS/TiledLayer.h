//
//  TiledLayer.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 11/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TilesSource.h"

@interface TiledLayer : CATiledLayer

@property (weak, nonatomic) TilesSource* tilesSource;

@end
