//
//  MapViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MapViewController.h"
#import "TouchXML.h"
#import "LocationService.h"
#import "Projection.h"

@interface MapViewController () <LocationServiceDelegate>

@property (weak, nonatomic) ViewController* mainViewController;
@property (strong, nonatomic) LocationService* locationService;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* doneButton;
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (weak, nonatomic) IBOutlet UILabel* label;

- (IBAction) onDoneButtonTap:(id)sender;

@end

@implementation MapViewController

@synthesize view;
@synthesize mainViewController;

- (id)initWithParentViewController:(ViewController*)viewController {
    if (self = [super init]) {
        
        // Store injected parameters
        self.mainViewController = viewController;
        
        // Load the XIB
        [[NSBundle mainBundle] loadNibNamed:@"MapViewController" owner:self options:nil];
        
        // Create the locationService
        self.locationService = [[LocationService alloc] init];
        self.locationService.delegate = self;
        [self.locationService start];
    }
    return self;
}

- (void) locationUpdate:(CLLocation *)location {
    [self.locationService stop];
    
    double latitudeInDegree = location.coordinate.latitude;
    double longitudeInDegree = location.coordinate.longitude;
    
    MWTilePoint tileRef = [Projection projWithLatitude:latitudeInDegree andLongitude:longitudeInDegree];
    NSURLRequest* tileRequest = [self getTileRequestForLevel:18 andTileRow:tileRef.tileRow andTileCol:tileRef.tileCol];
    UIImage* tileImage = [self getImageSynchronous:tileRequest];

    
    //[self getCapabilities];
    
    
    self.imageView.image = tileImage;
}



- (NSURLRequest*) getTileRequestForLevel:(int)level andTileRow:(int)tileRow andTileCol:(int)tileCol {
    
    // Forge the tile path
    NSString* tilePath = [NSString stringWithFormat:@"http://gpp3-wxs.ign.fr/f5vr9noizast10f92d822zor/wmts?LAYER=ORTHOIMAGERY.ORTHOPHOTOS&EXCEPTIONS=text/xml&FORMAT=image/jpeg&SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile&STYLE=normal&TILEMATRIXSET=PM&TILEMATRIX=%d&TILEROW=%d&TILECOL=%d&",level,tileRow, tileCol];
    
    NSLog(@"%@",tilePath);
    // Forge the TileRequest with userAgent information
    NSMutableURLRequest* tileRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:tilePath]];
    [tileRequest setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    
    return tileRequest;
}

- (UIImage*) getImageSynchronous:(NSURLRequest*)request {
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    return [[UIImage alloc] initWithData:data];
}

- (void) getCapabilities {
    NSURL* url = [NSURL URLWithString: @"http://gpp3-wxs.ign.fr/f5vr9noizast10f92d822zor/wmts?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetCapabilities"];
    
    CXMLDocument* document = [[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil];
    NSDictionary* nsMap = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"http://www.opengis.net/wmts/1.0", @"wmts",
                           @"http://www.opengis.net/ows/1.1", @"ows",
                           nil
                           ];
    NSArray* resultNodes = [document nodesForXPath:@"//wmts:Capabilities/ows:ServiceIdentification/ows:Title" namespaceMappings:nsMap error:nil];
    NSLog(@"count %d", resultNodes.count);
    for (CXMLElement *resultElement in resultNodes) {
        NSLog(@"CXMLElement %@", resultElement);
    }
}


- (void) didReceiveMemoryWarning {
    
}

- (IBAction) onDoneButtonTap:(id)sender {
    [self.mainViewController hideModalView];
}


@end
