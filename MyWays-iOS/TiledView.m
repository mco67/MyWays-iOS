//
//  TiledView.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 11/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "TiledView.h"
#import <QuartzCore/QuartzCore.h>
#import "TiledLayer.h"

@implementation TiledView

+ (Class) layerClass {
    return [TiledLayer class];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CATiledLayer* tiledLayer = (CATiledLayer*)self.layer;
        tiledLayer.levelsOfDetail = 10;
        tiledLayer.levelsOfDetailBias = 9;
    }
    return self;
}

@end
