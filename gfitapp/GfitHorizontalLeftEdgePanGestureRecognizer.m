//
//  GfitHorizontalLeftEdgePanGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 3/16/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitHorizontalLeftEdgePanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "GfitMainMenuViewController.h"
#import <tgmath.h>

@implementation GfitHorizontalLeftEdgePanGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    self.initialLocation = [self locationOnScreenWithTouch:[touches anyObject]];

    DLogCGFloat(self.initialLocation);

    [super touchesBegan:touches withEvent:event];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    //const CGFloat translation = [self translationOnScreenWithTouch:[touches anyObject]];

    //DLogCGFloat(translation);

    DLogCGFloat([self translationInView:self.view].x);

//    if (translation < 0) {
//        self.state = UIGestureRecognizerStateFailed;
//    }

    [super touchesMoved:touches withEvent:event];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    [self setGestureRecognizerEndedStateWithTouch:[touches anyObject]];
    [super touchesEnded:touches withEvent:event];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

    [self setGestureRecognizerEndedStateWithTouch:[touches anyObject]];

    [super touchesCancelled:touches withEvent:event];
}


- (void)setGestureRecognizerEndedStateWithTouch:(UITouch*)touch {

    //const CGFloat translation = [self translationOnScreenWithTouch:touch];
    //const CGFloat velocity = [self velocityInView:self.view].x;

    //BOOL translationPercent = (fabs(translation) < (kGfitGestureThreshold * CGRectGetWidth(self.view.frame)));
    //BOOL velocityPassed = (velocity < (-(kGfitVelocityThreshold)));

//    DLogBOOL((fabs(translation) > kGfitGestureThreshold * CGRectGetWidth(self.view.frame)));
//    DLogBOOL((velocity < -(kGfitVelocityThreshold)));
//    DLogCGFloat(velocity);
//    DLogfloat(fabs(translation));
//self.state = ((translationPercent || velocityPassed) ? UIGestureRecognizerStateRecognized
//    : UIGestureRecognizerStateCancelled);
    
}

@end
