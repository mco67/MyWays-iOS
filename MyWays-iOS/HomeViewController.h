//
//  HomeViewController.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface HomeViewController : NSObject

@property (weak, nonatomic) IBOutlet UIView* view;
@property (weak, nonatomic) IBOutlet UIView* maskView;

- (id)initWithParentViewController:(ViewController*)viewController;

@end
