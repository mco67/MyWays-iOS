//
//  ViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MainViewController.h"
#import "IIViewDeckController.h"

#import "CoreLocation/CoreLocation.h"
#import "ModalViewController.h"
#import "MenuViewController.h"
#import "WayListViewController.h"


@interface MainViewController ()

@property (strong, nonatomic) IIViewDeckController* viewDeckController;
@property (strong, nonatomic) MenuViewController* menuViewController;
@property (strong, nonatomic) WayListViewController* wayListViewController;

@end


@implementation MainViewController

@synthesize viewDeckController;
@synthesize menuViewController;
@synthesize wayListViewController;

- (id) init
{
    if (self = [super init]) {
        // Create the MenuViewController
        self.menuViewController = [[MenuViewController alloc] init];
        
        // Create the MyWaysListViewController
        self.wayListViewController = [[WayListViewController alloc] init];
        
        // Create the ViewDeck controller
        self.viewDeckController =  [[IIViewDeckController alloc] init];
        self.viewDeckController.leftController = self.menuViewController;
        self.viewDeckController.centerController = self.wayListViewController;
        
        // Register the viewDeck controller as childViewController
        [self addChildViewController:self.viewDeckController];
        self.viewDeckController.view.frame = self.view.bounds;
        [self.view addSubview:self.viewDeckController.view];
        [self.viewDeckController didMoveToParentViewController:self];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [self createAndAnimateSplashScreen];
}

- (void) createAndAnimateSplashScreen {
    
    // Create views for splashScreen animation
    UIImage* splashScreenImage = [UIImage imageNamed:@"Default"];
    UIView* splashScreenView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView* splashScreenLeftView = [[UIView alloc] init];
    UIView* splashScreenRightView  = [[UIView alloc] init];
    [self.view addSubview:splashScreenView];
    
    // Compute splittedSplashScreen size
    CGFloat splittedSplashScreenWidth = CGRectGetWidth(self.view.bounds)/2.0;
    CGFloat splittedSplashScreenHeight = CGRectGetHeight(self.view.bounds);
    
    // Create right splittedSplashScreen view
    splashScreenRightView = [[UIView alloc] init];
    splashScreenRightView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    splashScreenRightView.frame = CGRectMake(splittedSplashScreenWidth, 0 ,splittedSplashScreenWidth, splittedSplashScreenHeight);
    splashScreenRightView.clipsToBounds = TRUE;
    UIImageView* splittedRightImageView = [[UIImageView alloc] initWithImage:splashScreenImage];
    splittedRightImageView.frame = CGRectOffset(self.view.bounds, -splittedSplashScreenWidth, 0);
    [splashScreenRightView addSubview: splittedRightImageView];
    [splashScreenView addSubview:splashScreenRightView];
    
    // Create left splittedSplashScreen view
    splashScreenLeftView = [[UIView alloc] init];
    splashScreenLeftView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    splashScreenLeftView.frame = CGRectMake(0, 0 ,splittedSplashScreenWidth, splittedSplashScreenHeight);
    splashScreenLeftView.clipsToBounds = TRUE;
    UIImageView* splittedLeftImageView = [[UIImageView alloc] initWithImage:splashScreenImage];
    splittedLeftImageView.frame = CGRectOffset(self.view.bounds, 0, 0);
    [splashScreenLeftView addSubview: splittedLeftImageView];
    [splashScreenView addSubview:splashScreenLeftView];
    
    // Launch animation
    [UIView animateWithDuration:2.0f delay:1.0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CATransform3D rightTransform = CATransform3DIdentity;
                         CATransform3D leftTransform = CATransform3DIdentity;
                         rightTransform.m34 = leftTransform.m34 = -1.0/300.0;
                         rightTransform = CATransform3DRotate(rightTransform,M_PI_2, 0.0f, -1.0f, 0.0f);
                         leftTransform = CATransform3DRotate(leftTransform,M_PI_2, 0.0f, 1.0f, 0.0f);
                         splashScreenRightView.layer.transform = rightTransform;
                         splashScreenLeftView.layer.transform = leftTransform;
                         
                     }
                     completion:^(BOOL finished){
                         splashScreenView.hidden = TRUE;
                         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
                     }];
}



/*- (void) presentViewController:(UIViewController*) viewController {
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         CGFloat radius = 5.0f * M_PI / 180.0f;
                         CGFloat m34 = -1.0/300.0;
                         rotationAndPerspectiveTransform.m34 = m34;
                         rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform,radius, 1.0f, 0.0f, 0.0f);
                         self.homeContainerView.layer.transform = rotationAndPerspectiveTransform;
                     }
                     completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:0.0f delay:0.0f options:UIViewAnimationCurveEaseOut
                     animations:^{}
                     completion:^(BOOL finished){[self presentViewController:viewController animated:YES completion:nil];}];
}

- (void) dismissViewController {
    [UIView animateWithDuration:0.4f delay:0.1f options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         CGFloat radius = 0;
                         CGFloat m34 = 0;
                         rotationAndPerspectiveTransform.m34 = m34;
                         rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform,radius, 1.0f, 0.0f, 0.0f);
                         self.homeContainerView.layer.transform = rotationAndPerspectiveTransform ;
                         
                     }
                     completion:^(BOOL finished){}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
*/
@end
