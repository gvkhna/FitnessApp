//
//  GfitHorizontalEdgePanPercentDrivenInteractiveTransition.h
//  gfitapp
//
//  Created by Gaurav Khanna on 2/7/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitHorizontalEdgePanPercentDrivenInteractiveTransitionProtocol.h"

@interface GfitHorizontalEdgePanPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithDelegate:(id<GfitHorizontalEdgePanPercentDrivenInteractiveTransitionProtocol>)delegate;

@property (nonatomic, weak) id<GfitHorizontalEdgePanPercentDrivenInteractiveTransitionProtocol> delegate;

@property (nonatomic, assign) BOOL cancelledTransition;

//- (void)teardownDisplayLink;
- (void)teardownLeftEdgePanGestureRecognizer;
- (void)teardownRightEdgePanGestureRecognizer;
- (void)setupLeftEdgePanGestureRecognizer;
- (void)setupRightEdgePanGestureRecognizer;


@end
