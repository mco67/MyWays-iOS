//
//  HomeViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem* menuButton;
@property (weak, nonatomic) ViewController* mainViewController;

- (IBAction)onMenuButtonTap:(id)sender;

@end

@implementation HomeViewController

- (id)initWithParentViewController:(ViewController*)viewController {
    if (self = [super init]) {
        
        // Store injected parameters
        self.mainViewController = viewController;

        // Load the XIB
        [[NSBundle mainBundle] loadNibNamed:@"HomeViewController" owner:self options:nil];
        
        // Bring maskView to front
        [self.view bringSubviewToFront:self.maskView];
        
        self.menuButton.image = [UIImage imageNamed:@"navBar_menu_icon.png"];
    }
    return self;
}

- (IBAction)onMenuButtonTap:(id)sender {
    [self.mainViewController showHideInfoView];
}

@end
