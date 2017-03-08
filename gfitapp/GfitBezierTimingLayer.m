//
//  GfitBezierTimingLayer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/15/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitBezierTimingLayer.h"

static NSString * GfitBezierTimingLayerPosition = @"position";

@implementation GfitBezierTimingLayer

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {

    if ([anim isKindOfClass:[CABasicAnimation class]]) {

        CABasicAnimation *basicAnimation = (CABasicAnimation *)anim;
        NSValue *fromValue = basicAnimation.fromValue;
        NSValue *toValue = basicAnimation.toValue;
        NSValue *currentValue = [self valueForKeyPath:key];

        NSValue *actualFromValue = fromValue ? fromValue : currentValue;
        NSValue *actualToValue = toValue ? toValue : currentValue;

        BOOL shouldOverride = NO;

        if ([key isEqualToString:GfitBezierTimingLayerPosition]) {
            shouldOverride = YES;
        }

        if (shouldOverride) {

            CABasicAnimation *override = [CABasicAnimation animationWithKeyPath:key];
            override.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.17 :.67 :.83 :.67];
            //override.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.34 :.01 :.69 :1.37];
            //override.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            override.duration = anim.duration;
            override.beginTime = anim.beginTime;
            override.speed = anim.speed;
            override.timeOffset = anim.timeOffset;
            override.repeatCount = anim.repeatCount;
            override.repeatDuration = anim.repeatDuration;
            override.autoreverses = anim.autoreverses;
            override.fillMode = anim.fillMode;
            override.fromValue = actualFromValue;
            override.toValue = actualToValue;
            override.delegate = anim.delegate;
            override.removedOnCompletion = anim.removedOnCompletion;

            [super addAnimation:override forKey:key];

        } else {
            [super addAnimation:anim forKey:key];
        }
    } else {
        [super addAnimation:anim forKey:key];
    }

}

@end
