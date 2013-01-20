//
//  TiledLayer.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 11/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "TiledLayer.h"

@implementation TiledLayer

@synthesize tilesSource;

- (void)drawInContext:(CGContextRef)context {
    // Fetch clip box
    NSLog(@"--------------------");
    CGRect box = CGContextGetClipBoundingBox(context);
    NSLog(@"Draw in context (%f,%f)(%f,%f)",box.origin.x, box.origin.y, box.size.width, box.size.height);

    CGSize tileSize = [self tileSize];
    NSLog(@"Tile size (%f,%f)",tileSize.width, tileSize.height);

    CGFloat scaling = box.size.width / tileSize.width;
    NSLog(@"Scaling %f",scaling);

    CGFloat contentsScale = 2.0;
    CGFloat x = box.origin.x * contentsScale / tileSize.width;
	CGFloat y = box.origin.y * contentsScale / tileSize.height;
    TileCoordinates coordinates = MWTileCoordinatesMake(5+(int)y,6+(int)x);

    // Clear background
    CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextFillRect(context, box);

    CGContextSaveGState(context);
    UIImage* img = [self.tilesSource getTileImageForLevel:4 andTileCoordinates:coordinates];
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), [img CGImage]);
    
    CGContextRestoreGState(context);

    
}

- (void)drawInContext2:(CGContextRef)context {
    // Fetch clip box 
    CGRect box = CGContextGetClipBoundingBox(context);
    NSLog(@"drawin context (%f,%f)(%f,%f)",box.origin.x, box.origin.y, box.size.width, box.size.height);
    // Calculate tile index
	CGFloat contentsScale = [self respondsToSelector:@selector(contentsScale)]?[self contentsScale]:1.0;
	CGSize tileSize = [self tileSize];
    CGFloat scaling = box.size.width / tileSize.width;
    
	CGFloat x = box.origin.x * contentsScale / tileSize.width;
	CGFloat y = box.origin.y * contentsScale / tileSize.height;
    
    /*CGRect tbox = CGRectApplyAffineTransform(CGRectMake(0, 0, tileSize.width, tileSize.height),
                                             CGAffineTransformInvert(CGContextGetCTM(context)));
    CGFloat x = box.origin.x / tbox.size.width;
    CGFloat y = box.origin.y / tbox.size.height;*/
    
	CGPoint tile = CGPointMake(x, y);
    
    // Clear background
    CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextFillRect(context, box);
    
    // Rendering the contents
    CGContextSaveGState(context);
    CGContextConcatCTM(context, [self transformForTile:tile]);
    
    int zoomLevel = -log(scaling)/log(2);
    UIImage* img = [self imageForTile:tile atZoomLevel:zoomLevel];
    
    CGContextTranslateCTM(context, 0, box.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), [img CGImage]);
    
    CGContextRestoreGState(context);
}

- (CGAffineTransform)transformForTile:(CGPoint)tile {
    return CGAffineTransformIdentity;
}

- (UIImage*)imageForTile:(CGPoint)tile atZoomLevel:(int)zoomLevel
{
    NSLog(@"imageForTile (%f,%f) atZoomLevel %d", tile.x, tile.y, zoomLevel);
    NSString* urlString = [NSString stringWithFormat:@"http://xkcd1.rent-a-geek.de/converted/%d-%d-%d.png", zoomLevel, (int)tile.x, (int)tile.y];
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&response error:&error];
    return [[UIImage alloc] initWithData:data];
}

@end
