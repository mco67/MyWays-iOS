//
//  MapViewController.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : NSObject

@property (weak, nonatomic) IBOutlet UIView* view;

- (id) initWithParentViewController:(ViewController*)viewController;
- (void) didReceiveMemoryWarning;

@end
