//
//  ModalViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@property (weak, nonatomic) MainViewController* mainViewController;

@end

@implementation ModalViewController

@synthesize view;
@synthesize contentView;
@synthesize visible;
@synthesize mainViewController;

- (id) initWithParentViewController:(MainViewController*)viewController {
    if (self = [super init]) {
        
        // Store the mainViewController reference
        self.mainViewController = viewController;
        
        // Create the modal view
        CGRect frame = CGRectOffset(self.mainViewController.view.bounds, 0, CGRectGetHeight(self.mainViewController.view.bounds));
        self.view = [[UIView alloc] initWithFrame:frame];
    }
    return self;
}

- (void) setVisible:(Boolean)visible_ {
    visible = visible_;
    if (self.visible) self.view.frame = self.mainViewController.view.bounds;
    else self.view.frame = CGRectOffset(self.mainViewController.view.bounds, 0, CGRectGetHeight(self.mainViewController.view.bounds));    
}

- (void) setContentView:(UIView *)contentView_ {
    contentView = contentView_;
    
    // Remove subViews
    for (UIView* subView in self.view.subviews) [subView removeFromSuperview];
    
    // Add content subView
    [self.view addSubview:contentView];
}

- (void) didReceiveMemoryWarning {
    
}

@end
