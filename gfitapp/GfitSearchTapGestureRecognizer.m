//
//  GfitSearchTapGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchTapGestureRecognizer.h"

@implementation GfitSearchTapGestureRecognizer

#pragma mark - Object setup

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.delaysTouchesBegan = YES;
        self.delaysTouchesEnded = YES;
        self.minimumPressDuration = 0.001f;
    }
    return  self;
}

@end
