//
//  GfitBaseScreenEdgePanGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 3/16/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitBaseScreenEdgePanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation GfitBaseScreenEdgePanGestureRecognizer

#pragma mark - Base Setup

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        self.minimumNumberOfTouches = 1;
        self.maximumNumberOfTouches = 1;
        //self.delaysTouchesBegan = YES;
        //self.delaysTouchesEnded = YES;
    }
    return self;
}

#pragma mark - Point manipulation methods

- (CGFloat)locationOnScreenWithTouch:(UITouch*)touch {

    UIWindow *win = self.view.window;
    const CGPoint winLoc = [touch locationInView:win];
    DLogCGPoint(winLoc);

    return [win convertPoint:winLoc fromWindow:nil].x;
}


- (CGFloat)translationOnScreenWithTouch:(UITouch*)touch {

    UIWindow *win = self.view.window;
    const CGPoint winLoc = [touch locationInView:win];
    const CGPoint currentLocation = [win convertPoint:winLoc fromWindow:nil];
    //DLogCGPoint(currentLocation);

    return self.initialLocation - currentLocation.x;
}

- (void)setGestureRecognizerEndedStateWithTouch:(UITouch*)touch {

    NSAssert(YES, @"GfitBasePanGestureRecognizer subclass has no implementation: %@", self);
    
}

@end
