//
//  GfitMainMenuDynamicAnimator.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/16/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuDynamicAnimator.h"
#import "GfitSearchDraggableView.h"
#import "gfitapp-Constants.h"

const CGFloat kGfitDynamicPush = 8500;
const CGFloat kGfitDynamicDensity = 30;
const CGFloat kGfitDynamicResistance = 0.8;
const CGFloat kGfitDynamicGravity = 2;

@interface GfitMainMenuDynamicAnimator () <UIDynamicAnimatorDelegate>

@property (nonatomic, weak) UIViewController<GfitMainMenuDynamicAnimatorProtocol> *parent;
@property (nonatomic, weak) UIView<GfitMainMenuDynamicAnimatorViewsProtocol> *view;

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) NSBlockOperation *dynamicAnimatorCompletionBlock;

@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;

@end

@implementation GfitMainMenuDynamicAnimator

#pragma mark - Gesture recognizer setup

- (instancetype)initWithParent:(UIViewController<GfitMainMenuDynamicAnimatorProtocol> *)parent {
    self = [super init];
    if (self) {
        if ([parent conformsToProtocol:@protocol(GfitMainMenuDynamicAnimatorProtocol)]) {
            _parent = parent;
            _view = (UIView<GfitMainMenuDynamicAnimatorViewsProtocol> *)parent.view;

            self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.parent.view];
            self.dynamicAnimator.delegate = self;
        } else {
            return  nil;
        }
    }
    return self;
}



#pragma mark - Dynamic animator methods

- (void)teardownDynamicAnimator {

    [self.dynamicAnimator removeAllBehaviors];
    self.gravityBehavior = nil;
    self.attachmentBehavior = nil;
    self.dynamicItemBehavior = nil;
    
}


#pragma mark - Scan gesture methods

- (void)setupSearchGesture {
    @autoreleasepool {

        UIView *view = self.view.searchDraggableView;

        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[view]];
        UIEdgeInsets collisionBoundInsets = UIEdgeInsetsMake(0, 0, -(kGfitPanThreshold), 0);
        [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:collisionBoundInsets];
        [self.dynamicAnimator addBehavior:collisionBehavior];

        UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
        dynamicItemBehavior.allowsRotation = NO;

        GfitMainMenuDynamicAnimator * __weak weakSelf = self;
        self.dynamicItemBehavior.action = ^{
            GfitMainMenuDynamicAnimator *strongSelf = weakSelf;

            CGRect snapshotRect = strongSelf.view.searchDraggableView.frame;
            snapshotRect.origin.x = 0;
            strongSelf.view.searchDraggableView.frame = snapshotRect;
            
        };

        [self.dynamicAnimator addBehavior:dynamicItemBehavior];


        
    }
}

//- (void)searchGestureDidFinish:(BOOL)recognized {
//
//}

- (void)setupScanGesture {
    @autoreleasepool {
        UIView *view = self.view.scanDraggableViewSnapshot;

        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[view]];
        UIEdgeInsets collisionBoundInsets = UIEdgeInsetsMake(-(CGRectGetHeight(view.frame) - kGfitPanThreshold), 0, 0, 0);
        [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:collisionBoundInsets];
        [self.dynamicAnimator addBehavior:collisionBehavior];

        self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
        self.dynamicItemBehavior.allowsRotation = NO;

        GfitMainMenuDynamicAnimator * __weak weakSelf = self;
        self.dynamicItemBehavior.action = ^{
            GfitMainMenuDynamicAnimator *strongSelf = weakSelf;

            UIView *view = strongSelf.view.scanDraggableViewSnapshot;
            CGFloat percent = fabsf(CGRectGetMinY(view.frame) / (CGRectGetHeight(view.frame) - kGfitPanThreshold));
            strongSelf.view.scanStatusBarBackgroundImageView.alpha = percent;

            CGRect snapshotRect = strongSelf.view.scanDraggableViewSnapshot.frame;
            snapshotRect.origin.x = 0;
            strongSelf.view.scanDraggableViewSnapshot.frame = snapshotRect;
            
        };
        
        [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];
    }
}

- (void)setupSearchGestureAttachmentToLocation:(CGPoint)location {

    UIView *view = self.view.searchDraggableView;

    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:location];
    [self.dynamicAnimator addBehavior:self.attachmentBehavior];
}

- (void)setupScanGestureAttachmentToLocation:(CGPoint)location {

    UIView *view = self.view.scanDraggableViewSnapshot;

    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:location];
    [self.dynamicAnimator addBehavior:self.attachmentBehavior];
}

- (void)updateGestureAttachmentToLocation:(CGPoint)location {
    @autoreleasepool {
        self.attachmentBehavior.anchorPoint = location;
    }
}

//- (CGPoint)gestureAttachmentAnchorPoint {
//    return self.attachmentBehavior.anchorPoint;
//}
//
//- (void)setupSearchGestureFinishAttachmentToLocation:(CGPoint)location {
//    UIView *view = self.view.searchDraggableView;
//
//    [self.dynamicAnimator removeBehavior:self.attachmentBehavior];
//    
//    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:location];
//    [self.dynamicAnimator addBehavior:self.attachmentBehavior];
//    [self.dynamicAnimator updateItemUsingCurrentState:view];
//}

- (void)detachGestureAttachment {
    [self.dynamicAnimator removeBehavior:self.attachmentBehavior];
    self.attachmentBehavior = nil;
}


- (void)setupScanGestureDidFinishWithPush:(GfitMainMenuDynamicAnimatorDirection)show {

    UIView *view = self.view.scanDraggableViewSnapshot;

    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[view] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0, (kGfitDynamicPush * (show == GfitMainMenuDynamicAnimatorDirectionUp ? 1 : -1)));
    [self.dynamicAnimator addBehavior:pushBehavior];
    
}

- (void)setupSearchGestureFinishTransition:(BOOL)finished completion:(NSBlockOperation *)block {

    UIView *view = self.view.searchDraggableView;

    self.dynamicAnimatorCompletionBlock = block;

    [self.dynamicAnimator updateItemUsingCurrentState:view];

    self.dynamicItemBehavior.density = kGfitDynamicDensity;
    self.dynamicItemBehavior.resistance = kGfitDynamicResistance;

    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[view]];
    self.gravityBehavior.gravityDirection = CGVectorMake(0, kGfitDynamicGravity * ( finished ? 1 : -1));
    [self.dynamicAnimator addBehavior:self.gravityBehavior];


}

- (void)setupScanGestureDidFinishTransition:(BOOL)finished completion:(NSBlockOperation *)block {

    UIView *view = self.view.scanDraggableViewSnapshot;

    self.dynamicAnimatorCompletionBlock = block;

    [self.dynamicAnimator updateItemUsingCurrentState:view];

    self.dynamicItemBehavior.density = kGfitDynamicDensity;
    self.dynamicItemBehavior.resistance = kGfitDynamicResistance;

    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[view]];
    self.gravityBehavior.gravityDirection = CGVectorMake(0, kGfitDynamicGravity * ( finished ? -1 : 1));
    [self.dynamicAnimator addBehavior:self.gravityBehavior];

}

- (void)setupScanGestureDidFinishWithVelocity:(CGPoint)velocity {
    UIView *view = self.view.scanDraggableViewSnapshot;

    [self.dynamicItemBehavior addLinearVelocity:velocity forItem:view];
}


/**
 *  Plays the first launch animation
 */
- (void)playFirstLaunchAnimationWithCompletion:(NSBlockOperation *)block {

    //self.hueViewController.paused = YES;
    //self.view.userInteractionEnabled = NO;

    //[self.cameraViewController startRunningCaptureSession];

    const CGPoint searchCenter = self.view.searchDraggableView.center;

    GfitMainMenuDynamicAnimator * __weak weakSelf = self;
    [UIView animateWithDuration:kGfitTransitionFastTime delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        GfitMainMenuDynamicAnimator *strongSelf = weakSelf;

        CGPoint lowerCenter = searchCenter;
        lowerCenter.y += kGfitPanThreshold;
        strongSelf.view.searchDraggableView.center = lowerCenter;

    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:kGfitTransitionFastTime delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                GfitMainMenuDynamicAnimator *strongSelf = weakSelf;

                strongSelf.view.searchDraggableView.center = searchCenter;

            } completion:^(BOOL finished) {
                if (finished) {
                    GfitMainMenuDynamicAnimator *strongSelf = weakSelf;

                    [strongSelf setupScanGesture];

                    [strongSelf setupScanGestureDidFinishTransition:NO completion:block];
                }
            }];
        }
    }];
}

#pragma mark - Dynamic animator delegate methods

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
    //self.hueViewController.paused = YES;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {

    if (!self.gravityBehavior) {
        // not a scanning gesture
        return;
    }

    UIView *view = self.view.scanDraggableViewSnapshot;
    const CGFloat height = view.frame.size.height;
    const CGFloat origin = view.frame.origin.y;
    const CGFloat epsilon = 1;
    NSInteger scanning = -1;

    if ((height - kGfitPanThreshold) + origin < epsilon) {

        scanning = 1;

    } else if (origin > -(epsilon) && origin < epsilon) {

        scanning = 0;

    }

    if (scanning > -1) {

        DLogFunctionLine();
        GfitMainMenuDynamicAnimator * __weak weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            GfitMainMenuDynamicAnimator *strongSelf = weakSelf;

            //[strongSelf teardownDynamicAnimator];

            //[strongSelf.view showScan:scanning animated:NO];
            //strongSelf.hueViewController.paused = NO;

            //            if (scanning) {
            //                [strongSelf setupScanningGestureRecognizers];
            //            } else {
            //                [strongSelf setupMainMenuGestureRecognizers];
            //            }

            [strongSelf.dynamicAnimatorCompletionBlock setCompletionBlock:^{
                weakSelf.dynamicAnimatorCompletionBlock = nil;
            }];
            
            [strongSelf.dynamicAnimatorCompletionBlock start];
            
        });
        
    }
}

@end
