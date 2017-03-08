//
//  UIView+RecursiveLayout.m
//  gfitapp
//
//  Created by Gaurav Khanna on 4/25/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "UIView+RecursiveLayout.h"

@implementation UIView (RecursiveLayout)

- (void)setNeedsLayoutRecursively {
    for (UIView *view in self.subviews) {
        [view setNeedsLayoutRecursively];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
