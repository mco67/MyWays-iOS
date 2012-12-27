//
//  MenuViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MenuViewController.h"
#import "Utils.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UIView* headerView;
@property (weak, nonatomic) ViewController* mainViewController;

@end

@implementation MenuViewController

- (id)initWithParentViewController:(ViewController*)viewController {
    if (self = [super init]) {
        
        // Store injected parameters
        self.mainViewController = viewController;
        
        // Load the XIB
        [[NSBundle mainBundle] loadNibNamed:@"MenuViewController" owner:self options:nil];
        
        // Configure headerView background
        self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar_background_dark.png"]];
    }
    return self;
}


@end
