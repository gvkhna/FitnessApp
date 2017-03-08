//
//  UIView+GAnimateBlock.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/9/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "UIView+GAnimateBlock.h"

@implementation UIView (GAnimateBlock)

+ (void)g_performAnimations:(BOOL)animate blockOperation:(NSBlockOperation*)updateOperation {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (animate) {
            [updateOperation start];
        } else {
            [UIView performWithoutAnimation:^{
                [updateOperation start];
            }];
        }
    });
}

@end
