//
//  ViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "ViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "ModalViewController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"


@interface ViewController ()

@property (strong, nonatomic) ModalViewController* modalViewController;
@property (strong, nonatomic) MenuViewController* menuViewController;
@property (strong, nonatomic) HomeViewController* homeViewController;
@property (strong, nonatomic) UIView* homeContainerView;

@end


@implementation ViewController

@synthesize modalViewController;
@synthesize menuViewController;
@synthesize homeViewController;
@synthesize homeContainerView;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Create container for home and menu views;
    self.homeContainerView = [[UIView alloc] init];
    self.homeContainerView.clipsToBounds = TRUE;
    self.homeContainerView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    self.homeContainerView.layer.frame = self.view.bounds;
    self.homeContainerView.layer.cornerRadius = 3;

    [self.view addSubview:self.homeContainerView];
    
    // Create the MenuViewController
    self.menuViewController = [[MenuViewController alloc] initWithParentViewController:self];
    [self.homeContainerView addSubview:self.menuViewController.view];
    
    // Create the HomeViewController
    self.homeViewController = [[HomeViewController alloc] initWithParentViewController:self];
    [self.homeContainerView addSubview:self.homeViewController.view];
    
    // Create the ModalViewController
    self.modalViewController = [[ModalViewController alloc] initWithParentViewController:self];
    [self.view addSubview:self.modalViewController.view];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.menuViewController didReceiveMemoryWarning];
    [self.homeViewController didReceiveMemoryWarning];
    [self.modalViewController didReceiveMemoryWarning];
}


- (void) showHideInfoView {
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

- (void) showModalView:(UIView*)view {
    self.modalViewController.contentView = view;
    
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         CGFloat radius = 5.0f * M_PI / 180.0f;
                         CGFloat m34 = -1.0/300.0;
                         rotationAndPerspectiveTransform.m34 = m34;
                         rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform,radius, 1.0f, 0.0f, 0.0f);
                         self.homeContainerView.layer.transform = rotationAndPerspectiveTransform;
                     }
                     completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:0.4f delay:0.1f options:UIViewAnimationCurveEaseOut
                     animations:^{self.modalViewController.visible = TRUE;}
                     completion:^(BOOL finished){}];
}

- (void) hideModalView {
    
    [UIView animateWithDuration:0.5f delay:0.1f options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         CGFloat radius = 0;
                         CGFloat m34 = 0;
                         rotationAndPerspectiveTransform.m34 = m34;
                         rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform,radius, 1.0f, 0.0f, 0.0f);
                         self.homeContainerView.layer.transform = rotationAndPerspectiveTransform ;
                         
                     }
                     completion:^(BOOL finished){}];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{self.modalViewController.visible = FALSE;}
                     completion:^(BOOL finished){}];
}

@end
