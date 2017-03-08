//
//  GfitScanningTapGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/7/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitScanningTapGestureRecognizer.h"

@implementation GfitScanningTapGestureRecognizer

#pragma mark - Object setup

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.delaysTouchesBegan = YES;
        self.delaysTouchesEnded = YES;
    }
    return  self;
}

@end
