//
//  GfitBasePanGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/8/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitBasePanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation GfitBasePanGestureRecognizer

#pragma mark - Base Setup

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.minimumNumberOfTouches = 1;
        self.maximumNumberOfTouches = 1;
        self.delaysTouchesBegan = NO;
        self.delaysTouchesEnded = NO;
    }
    return self;
}

#pragma mark - Point manipulation methods

- (CGFloat)locationOnScreenWithTouch:(UITouch*)touch {

    UIWindow *win = self.view.window;
    const CGPoint winLoc = [touch locationInView:win];

    return [win convertPoint:winLoc fromWindow:nil].y;
}


- (CGFloat)translationOnScreenWithTouch:(UITouch*)touch {

    UIWindow *win = self.view.window;
    const CGPoint winLoc = [touch locationInView:win];
    const CGPoint currentLocation = [win convertPoint:winLoc fromWindow:nil];

    return self.initialLocation - currentLocation.y;
}

- (void)setGestureRecognizerEndedStateWithTouch:(UITouch*)touch {

    NSAssert(YES, @"GfitBasePanGestureRecognizer subclass has no implementation: %@", self);
    
}


@end
