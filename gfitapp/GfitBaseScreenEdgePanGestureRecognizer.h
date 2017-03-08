//
//  GfitBaseScreenEdgePanGestureRecognizer.h
//  gfitapp
//
//  Created by Gaurav Khanna on 3/16/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GfitBaseScreenEdgePanGestureRecognizer : UIScreenEdgePanGestureRecognizer

@property (nonatomic, assign) CGFloat initialLocation;

- (CGFloat)locationOnScreenWithTouch:(UITouch*)touch;
- (CGFloat)translationOnScreenWithTouch:(UITouch*)touch;
- (void)setGestureRecognizerEndedStateWithTouch:(UITouch*)touch;

@end
