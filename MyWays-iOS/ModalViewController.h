//
//  ModalViewController.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 28/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModalViewController : NSObject

@property (strong, nonatomic) UIView* view;
@property (strong, nonatomic) UIView* contentView;
@property (nonatomic) Boolean visible;

- (id)initWithParentViewController:(MainViewController*)viewController;
- (void) didReceiveMemoryWarning;

@end
