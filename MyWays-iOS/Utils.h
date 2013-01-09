//
//  Utils.h
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef HEXCOLOR
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#endif

static inline BOOL IsNullOrEmpty(id thing) {
    return thing == nil || ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)] && [(NSArray *)thing count] == 0);
}

typedef struct {
    int tileRow;
    int tileCol;
} MWTilePoint;

static inline MWTilePoint MWTilePointMake(int tileRow, int tileCol) {
    MWTilePoint p; p.tileRow = tileRow; p.tileCol = tileCol; return p;
}

@interface Utils : NSObject

@end
