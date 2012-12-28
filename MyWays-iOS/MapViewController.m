//
//  MapViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) ViewController* mainViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* doneButton;

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
    }
    return self;
}

- (void) didReceiveMemoryWarning {
    
}

- (IBAction) onDoneButtonTap:(id)sender {
    [self.mainViewController hideModalView];
}


@end
