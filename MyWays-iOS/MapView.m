//
//  MapService.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "MapView.h"
#import "TilesSource.h"
#import "TilesSourceCapabilities.h"
#import "TiledView.h"
#import "TiledLayer.h"


const static CGSize tileSize = {256, 256};


@interface MapView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIView* contentView;
@property (strong, nonatomic) NSMutableArray* tileViews;
@property (strong, nonatomic) NSMutableSet*	extraTileViews;
@property (nonatomic) CGRect tileBox;
@property (nonatomic) CGSize worldSize;
@property (nonatomic) CGFloat scale;
@property (nonatomic) NSInteger level;

@end


@implementation MapView


@synthesize contentView;
@synthesize tileViews;
@synthesize extraTileViews;
@synthesize tileBox;
@synthesize worldSize;
@synthesize scale;
@synthesize level;

- (id) initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        
        // Configure self scrollView
        self.delegate = self;
        self.zoomScale = 1;
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 2;
        self.bouncesZoom = NO;
        self.bounces = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.scale = 1;
        self.level = 1;
        self.tileBox = CGRectZero;
        self.worldSize = CGSizeMake(256.0, 256.0); 
        
        [self createTileViews];
        
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        [self sizeContent];
    }
    return self;
} 

- (void) sizeContent {
	self.contentView.frame = CGRectMake(0, 0, self.worldSize.width*self.scale, self.worldSize.height*self.scale);
	self.contentSize = CGSizeMake(CGRectGetMaxX(self.contentView.frame), CGRectGetMaxY(self.contentView.frame));
}


#pragma mark - UIScrollView delegate implementation

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGFloat w = tileSize.width;
	CGFloat h = tileSize.height;
    CGRect contentViewBounds = self.contentView.bounds;
        
    // Compute the viewPort frame in contentView system
    CGRect viewport = CGRectIntersection([self.contentView convertRect:self.bounds fromView:self], contentViewBounds);

    // Free not visible existing tiles
	for (UIView* tileView in [self.contentView subviews]) {
		if (!CGRectIntersectsRect(viewport, tileView.frame)) {
			[tileView removeFromSuperview];
			[self.extraTileViews addObject:tileView];
		}
	}
    
    // Store old tileBox value
    NSInteger oldMinCol = self.tileBox.origin.x;
	NSInteger oldMinRow = self.tileBox.origin.y;
	NSInteger oldMaxCol = CGRectGetMaxX(self.tileBox)-1;
	NSInteger oldMaxRow = CGRectGetMaxY(self.tileBox)-1;

    // Compute new tileBox value
    self.tileBox = CGRectIntegral(CGRectApplyAffineTransform(viewport, CGAffineTransformMakeScale(1/w, 1/h)));
	
    for (int bw = self.tileBox.size.width, n = bw*self.tileBox.size.height-1; n >= 0; n--) {
		NSInteger c = tileBox.origin.x + n % bw;
		NSInteger r = tileBox.origin.y + n / bw;
		
		//	If missing, create
		if ((c < oldMinCol) || (c > oldMaxCol) || (r < oldMinRow) || (r > oldMaxRow)) {
            
            // Fetch the tile image
            TileCoordinates tileCoordinates = MWTileCoordinatesMake(r,c);
            UIImage* image = [self.tilesSource getTileImageForLevel:self.level andTileCoordinates:tileCoordinates];

            // Compute the tile frame
            CGRect tileFrame = CGRectMake(c*w, r*h, w, h);
			
            // Create or reuse existing tile
            [self addTileForFrame:tileFrame andImage:image];
        }
	}

    
}

- (void)scrollViewDidEndZooming:(UIScrollView*)scrollView withView:(UIView*)view atScale:(float)relScale {
    CGPoint offset = self.contentOffset;
    self.zoomScale = 1.0;
	self.scale *= relScale;
    
    NSLog(@"log %f",log(self.scale)/log(2));
    NSInteger puiss = floor(log(self.scale)/log(2));
    self.level = self.scale<pow(2,puiss)?puiss-1:puiss;
    NSLog(@"scale %f puiss %d level %d", self.scale, puiss, self.level);
    [self sizeContent];
    self.contentOffset = offset;
    [self reload];
}

- (UIView*) viewForZoomingInScrollView:(UIScrollView*)scrollView {
	return self.contentView;
}

#pragma mark - Tiles manipulation methods

- (void) createTileViews {
	if (self.tileViews) [self removeTileViews];
	self.tileViews = [[NSMutableArray alloc] initWithCapacity:4];
	self.extraTileViews = [[NSMutableSet alloc] initWithCapacity:4];
}

- (void) removeTileViews {
	for (UIView* tileView in self.tileViews)
		[tileView removeFromSuperview];
	self.tileViews = nil;
    self.extraTileViews = nil;
}

- (UIImageView*) addTileForFrame:(CGRect)frame andImage:(UIImage*)image {
	UIImageView* tileView = [self.extraTileViews anyObject];
	if (tileView) [self.extraTileViews removeObject:tileView];
	else {
		tileView = [[UIImageView alloc] init];
		tileView.clearsContextBeforeDrawing = NO;
		[self.tileViews addObject:tileView];
	}	
	[self.contentView addSubview:tileView];
    tileView.image = image;
	tileView.frame = frame;
	[tileView setNeedsDisplay];
   	return tileView;
}

- (void) reload {
	for (UIView* tileView in self.contentView.subviews) {
		[tileView removeFromSuperview];
		[self.extraTileViews addObject:tileView];
	}
	self.tileBox = CGRectZero;
    [self scrollViewDidScroll:self];
}


@end
