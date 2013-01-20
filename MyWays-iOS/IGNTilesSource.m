//
//  IGNTilesSource.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 10/01/13.
//  Copyright (c) 2013 Mathieu Cordebard. All rights reserved.
//

#import "IGNTilesSource.h"
#import "IGNTilesSourceCapabilities.h"
#import "TouchXML.h"
#import <math.h>

#define EQUAT_RADIUS 6378137.0
#define PIXEL_PITCH 0.28
#define TILE_RES 256

NSString* const IGNLicenceKey = @"f5vr9noizast10f92d822zor";


@implementation IGNTilesSource

@synthesize capabilities;

#pragma mark - CORE lifeCycle

- (id) init {
    if (self = [super init]) {
        [self initTilesSourceCapabilities];
    }
    return self;
}

- (void) initTilesSourceCapabilities {

    // Forge the getCapapilities webService URL
    NSString* getCapabilitiesPath = [NSString stringWithFormat:@"http://gpp3-wxs.ign.fr/%@/wmts?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetCapabilities", IGNLicenceKey ];
    NSURL* getCapabilitiesURL = [NSURL URLWithString:getCapabilitiesPath];

    // Declare used namespaces
    NSDictionary* nsMap = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.opengis.net/wmts/1.0", @"wmts", @"http://www.opengis.net/ows/1.1", @"ows", nil];
    
    // Request the capabilities XML document
    CXMLDocument* capabilitiesXMLDoc = [[CXMLDocument alloc] initWithContentsOfURL:getCapabilitiesURL options:0 error:nil];

    // Extract the TileMatrix list
    NSString* xPath = @"//wmts:Capabilities/wmts:Contents/wmts:TileMatrixSet[ows:Identifier='PM']/wmts:TileMatrix";
    NSArray* tileMatrixElements = [capabilitiesXMLDoc nodesForXPath:xPath namespaceMappings:nsMap error:nil];

    // Allocate temporary unordonedTileMatrixs Array
    NSMutableArray* unordonedTileMatrixs = [[NSMutableArray alloc] init];
    
    // Traverse tileMatrixElements list
    for (CXMLElement* tileMatrixElement in tileMatrixElements) {
        
        // Create the IGNtileMatrixObject
        IGNTilesMatrix* tileMatrix = [[IGNTilesMatrix alloc] init];
        
        // Extract level
        tileMatrix.level = [[[tileMatrixElement childAtIndex:0] stringValue] intValue];
        
        // Extract scaleDenominator
        tileMatrix.scaleDenominator = [[[tileMatrixElement childAtIndex:1] stringValue] doubleValue];
        
        // Extract topLeftCorner
        NSArray* topLeftCornerArray = [[[tileMatrixElement childAtIndex:2] stringValue] componentsSeparatedByString: @" "];
        tileMatrix.topLeftX = [[topLeftCornerArray objectAtIndex:0] integerValue];
        tileMatrix.topLeftY = [[topLeftCornerArray objectAtIndex:1] integerValue];

        // Compute tile border width
        tileMatrix.tileBorderWidth = PIXEL_PITCH * TILE_RES * tileMatrix.scaleDenominator / 1000;
        [unordonedTileMatrixs addObject:tileMatrix];
    }

    // Reorder (by ascendent level) unorderedTileMatrixs array
    NSArray* sortDescriptors = [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"level" ascending:YES]];
    NSArray* orderedTileMatrixs = [unordonedTileMatrixs sortedArrayUsingDescriptors:sortDescriptors];
    
    // Create and return the tilesSourceCapabilities object
    self.capabilities = [[TilesSourceCapabilities alloc] initWithTileMatrixs:orderedTileMatrixs];
}

#pragma mark - CORE public interface

- (TileCoordinates) getTileCoordinatesForLevel:(int)level andLatitudeInDegrees:(double)latitudeInDegrees andLongitudeInDegrees:(double)longitudeInDegrees {
    
    // Get the tileMatrix associated to this level
    IGNTilesMatrix* tileMatrix = [self.capabilities.tilesMatrixs objectAtIndex:level];
    
    // Convert latitude and longitude in radian system
    double latRadian = latitudeInDegrees * M_PI/180;
    double longRadian = longitudeInDegrees * M_PI/180;
    
    // Compute coordinates in webMercator referentiel
    double X = EQUAT_RADIUS * longRadian;
    double Y = EQUAT_RADIUS * log(tan(latRadian/2 + M_PI_4));
    double x = X - tileMatrix.topLeftX;
    double y = tileMatrix.topLeftY - Y;
    
    // Compute TILEROW and TILECOL in dedicatet MatrixSet
    int TILEROW = (int)(y/tileMatrix.tileBorderWidth);
    int TILECOL = (int)(x/tileMatrix.tileBorderWidth);
    
    return MWTileCoordinatesMake(TILEROW, TILECOL);
}

- (UIImage*) getTileImageForLevel:(int)level andTileCoordinates:(TileCoordinates)tileCoordinates {
    NSURLRequest* request = [self getTileRequestForLevel:level andTileCoordinates:tileCoordinates];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return [[UIImage alloc] initWithData:data];
}

- (NSURLRequest*) getTileRequestForLevel:(int)level andTileCoordinates:(TileCoordinates)tileCoordinates {
    
    // Forge the tile path
    NSString* tilePath = [NSString stringWithFormat:@"http://gpp3-wxs.ign.fr/f5vr9noizast10f92d822zor/wmts?LAYER=ORTHOIMAGERY.ORTHOPHOTOS&EXCEPTIONS=text/xml&FORMAT=image/jpeg&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&STYLE=normal&TILEMATRIXSET=PM&TILEMATRIX=%d&TILEROW=%d&TILECOL=%d&",level,tileCoordinates.tileRow, tileCoordinates.tileCol];
    
    // Forge the TileRequest with userAgent information
    NSMutableURLRequest* tileRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:tilePath]];
    [tileRequest setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    
    return tileRequest;
}





@end
