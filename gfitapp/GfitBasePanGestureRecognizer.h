//
//  GfitBasePanGestureRecognizer.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/8/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GfitBasePanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) CGFloat initialLocation;

- (CGFloat)locationOnScreenWithTouch:(UITouch*)touch;
- (CGFloat)translationOnScreenWithTouch:(UITouch*)touch;
- (void)setGestureRecognizerEndedStateWithTouch:(UITouch*)touch;

@end
