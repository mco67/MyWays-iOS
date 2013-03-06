//
//  AppDelegate.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"


@interface AppDelegate()

@property (strong, nonatomic) MainViewController* mainViewController;

@end


@implementation AppDelegate

@synthesize mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create the main window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Customize application look and feel
    [self lookAndFeelCustomisation];

    // Create the mainView controller
    self.mainViewController = [[MainViewController alloc] init];
    
    // Assign ViewDeck controller as rootViewController
    self.window.rootViewController = self.mainViewController;
    
    // Display the main window
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)lookAndFeelCustomisation
{
    // Customize navigationBar background
    UIImage* navbarBackground = [UIImage imageNamed:@"navBar_background_light.png"];
    [[UINavigationBar appearance] setBackgroundImage:navbarBackground forBarMetrics:UIBarMetricsDefault];
    
    // Customize navigationBar buttons
    UIImage* navBarButton = [[UIImage imageNamed:@"navBar_button_active"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage* navBarButtonPress = [[UIImage imageNamed:@"navBar_button_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:navBarButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:navBarButtonPress forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          HEXCOLOR(0x000000FF), UITextAttributeTextColor,
                                                          [UIFont fontWithName:@"Helvetica-Light" size:(15.0)],UITextAttributeFont,
                                                          [UIColor clearColor],UITextAttributeTextShadowColor,nil] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          HEXCOLOR(0xFFFFFFFF), UITextAttributeTextColor,
                                                          [UIFont fontWithName:@"Helvetica-Light" size:(15.0)],UITextAttributeFont,
                                                          [UIColor clearColor],UITextAttributeTextShadowColor,nil] forState:UIControlStateHighlighted];
    
    // Customize the navigationBar font
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          HEXCOLOR(0x000000FF), UITextAttributeTextColor,
                                                          [UIFont fontWithName:@"Helvetica-Light" size:(18.0)],UITextAttributeFont,
                                                          [UIColor clearColor],UITextAttributeTextShadowColor,nil]];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
