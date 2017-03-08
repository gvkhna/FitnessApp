//
//  GfitSearchPanGestureRecognizer.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/6/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchPanGestureRecognizer.h"
#import "GfitMainMenuViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation GfitSearchPanGestureRecognizer


#pragma mark - Touch event methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    self.initialLocation = [self locationOnScreenWithTouch:[touches anyObject]];
    [super touchesBegan:touches withEvent:event];
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    const CGFloat translation = [self translationOnScreenWithTouch:[touches anyObject]];

    DLogCGFloat(translation);

    if (translation > 0) {
        self.state = UIGestureRecognizerStateFailed;
    } else if (translation < -(kGfitPanThreshold)) {
        self.state = UIGestureRecognizerStateRecognized;
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

    CGFloat translation = [self translationOnScreenWithTouch:touch];
    self.state = (translation > kGfitPanThreshold) ? UIGestureRecognizerStateRecognized : UIGestureRecognizerStateCancelled;
    
}

@end
