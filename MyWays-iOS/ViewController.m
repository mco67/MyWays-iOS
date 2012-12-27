//
//  ViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "ViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "MenuViewController.h"
#import "HomeViewController.h"


@interface ViewController ()

@property (strong, nonatomic) MenuViewController* menuViewController;
@property (strong, nonatomic) HomeViewController* homeViewController;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor redColor];
    
    // Create the MenuViewController
    self.menuViewController = [[MenuViewController alloc] initWithParentViewController:self];
    [self.view addSubview:self.menuViewController.view];
    
    // Create the HomeViewController
    self.homeViewController = [[HomeViewController alloc] initWithParentViewController:self];
    [self.view addSubview:self.homeViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)showHideInfoView {
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         UIView* homeView = self.homeViewController.view;
                         UIView* maskView = self.homeViewController.maskView;

                         CGSize size = homeView.frame.size;
                         NSInteger xpos = (homeView.frame.origin.x == 0)?size.width - 55:0;
                         homeView.frame = CGRectMake(xpos, 0, size.width, size.height);
                         maskView.hidden = (homeView.frame.origin.x == 0);
                     }
                     completion:^(BOOL finished){}];
}

@end
