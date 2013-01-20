//
//  MapService.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TilesSource.h"
#import "TiledView.h"

@interface MapView : UIScrollView

@property (strong, nonatomic) TilesSource* tilesSource;

- (void) reload;

@end
