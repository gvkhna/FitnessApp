//
//  GfitMainMenuDynamicAnimator.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/16/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GfitMainMenuViewController.h"

typedef NS_ENUM(NSInteger, GfitMainMenuDynamicAnimatorDirection) {
    GfitMainMenuDynamicAnimatorDirectionUp,
    GfitMainMenuDynamicAnimatorDirectionDown
};

extern const CGFloat kGfitDynamicPush;
extern const CGFloat kGfitDynamicDensity;
extern const CGFloat kGfitDynamicResistance;
extern const CGFloat kGfitDynamicGravity;

@interface GfitMainMenuDynamicAnimator : NSObject

- (instancetype)initWithParent:(UIViewController<GfitMainMenuDynamicAnimatorProtocol> *)parent;
- (void)teardownDynamicAnimator;

- (void)playFirstLaunchAnimationWithCompletion:(NSBlockOperation*)block;

- (void)setupSearchGesture;
- (void)setupSearchGestureAttachmentToLocation:(CGPoint)location;

//- (CGPoint)gestureAttachmentAnchorPoint;
//- (void)setupSearchGestureFinishAttachmentToLocation:(CGPoint)location;
- (void)setupSearchGestureFinishTransition:(BOOL)finished completion:(NSBlockOperation *)block;

- (void)setupScanGesture;
- (void)setupScanGestureAttachmentToLocation:(CGPoint)location;

- (void)updateGestureAttachmentToLocation:(CGPoint)location;
- (void)detachGestureAttachment;

- (void)setupScanGestureDidFinishTransition:(BOOL)finished completion:(NSBlockOperation*)block;
- (void)setupScanGestureDidFinishWithVelocity:(CGPoint)velocity;
- (void)setupScanGestureDidFinishWithPush:(GfitMainMenuDynamicAnimatorDirection)show;

@end
