//
//  MenuViewController.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MenuViewController : NSObject

@property (strong, nonatomic) IBOutlet UIView* view;

- (id)initWithParentViewController:(ViewController*)viewController;

@end
