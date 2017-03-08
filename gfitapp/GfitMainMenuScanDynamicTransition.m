//
//  GfitMainMenuScanDynamicTransition.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/19/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuScanDynamicTransition.h"

@implementation GfitMainMenuScanDynamicTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 5.0;
    //return kGfitTransitionFastTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DLogFunctionLine();
}

@end
