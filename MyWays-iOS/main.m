//
//  main.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "UIImage+Additions_568.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        [UIImage patchImageNamedToSupport568Resources];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
