//
//  GfitScanPanGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/6/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitScanPanGestureRecognizer.h"
#import "GfitMainMenuViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation GfitScanPanGestureRecognizer

#pragma mark - Touch event methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    self.initialLocation = [self locationOnScreenWithTouch:[touches anyObject]];

    //DLogCGFloat(self.initialLocation);

    [super touchesBegan:touches withEvent:event];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    const CGFloat translation = [self translationOnScreenWithTouch:[touches anyObject]];

    //DLogCGFloat(translation);

    if (translation < 0) {
        self.state = UIGestureRecognizerStateFailed;
    }

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

    const CGFloat translation = [self translationOnScreenWithTouch:touch];
    const CGFloat velocity = [self velocityInView:self.view].y;

    self.state = (translation > kGfitGestureThreshold * CGRectGetHeight(self.view.frame) || velocity < -(kGfitVelocityThreshold))
    ? UIGestureRecognizerStateRecognized
    : UIGestureRecognizerStateCancelled;

}


@end
