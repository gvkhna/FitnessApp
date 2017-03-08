//
//  GfitHorizontalEdgePanPercentDrivenInteractiveTransition.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/7/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitHorizontalEdgePanPercentDrivenInteractiveTransition.h"
#import "UIWindow+SBWindow.h"
#import "GfitMainMenuViewController.h"
#import "GfitHorizontalLeftEdgePanGestureRecognizer.h"
#import "GfitHorizontalRightEdgePanGestureRecognizer.h"
#import "GfitSerialOperationQueue.h"
#import <tgmath.h>

@interface GfitHorizontalEdgePanPercentDrivenInteractiveTransition () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *leftEdgePanGestureRecognizer;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *rightEdgePanGestureRecognizer;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, strong) UIWindow *statusBarWindow;

@property (nonatomic, assign) CFTimeInterval statusBarWindowBeginTime;
@property (nonatomic, assign) CFTimeInterval statusBarWindowEndTime;
@property (nonatomic, assign) CGFloat statusBarWindowPercentComplete;
@property (nonatomic, assign) CFTimeInterval statusBarDisplayLinkBeginTimestamp;
@property (nonatomic, assign) CFTimeInterval statusBarDisplayLinkEndTimestamp;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) GfitSerialOperationQueue *operationQueue;

@property (nonatomic, strong) CABasicAnimation *statusBarAnimation;

@end

@implementation GfitHorizontalEdgePanPercentDrivenInteractiveTransition

/*
*  Designated object initializer
*
*  @param nc the `UINavigationController` object to attach a `UIScreenEdgePanGestureRecognizer` to
*
*  @return the fully initialized object
*/
- (instancetype)initWithDelegate:(id<GfitHorizontalEdgePanPercentDrivenInteractiveTransitionProtocol>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _operationQueue = [GfitSerialOperationQueue new];

    }
    return self;
}

- (void)setupRightEdgePanGestureRecognizer {
    self.rightEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightEdgePanGestureRecognizer:)];
    self.rightEdgePanGestureRecognizer.delegate = self;
    self.rightEdgePanGestureRecognizer.edges = UIRectEdgeRight;

    UIView *delegateView = [self.delegate performSelector:@selector(view) withObject:nil];
    if (delegateView) {
        [delegateView addGestureRecognizer:self.rightEdgePanGestureRecognizer];
    }
}

- (void)setupLeftEdgePanGestureRecognizer {
    self.leftEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftEdgePanGestureRecognizer:)];
    self.leftEdgePanGestureRecognizer.delegate = self;
    self.leftEdgePanGestureRecognizer.edges = UIRectEdgeLeft;

    UIView *delegateView = [self.delegate performSelector:@selector(view) withObject:nil];
    if (delegateView) {
        [delegateView addGestureRecognizer:self.leftEdgePanGestureRecognizer];
    }
}

- (void)teardownRightEdgePanGestureRecognizer {
    UIView *delegateView = [self.delegate performSelector:@selector(view) withObject:nil];
    if (delegateView) {
        [delegateView removeGestureRecognizer:self.leftEdgePanGestureRecognizer];
    }
    self.leftEdgePanGestureRecognizer = nil;
}

- (void)teardownLeftEdgePanGestureRecognizer {
    UIView *delegateView = [self.delegate performSelector:@selector(view) withObject:nil];
    if (delegateView) {
        [delegateView removeGestureRecognizer:self.rightEdgePanGestureRecognizer];
    }
    self.rightEdgePanGestureRecognizer = nil;
}

//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
//    return 0.35f;
//}
//
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *toView = toVC.view;
//    UIView *fromView = fromVC.view;
//
//    // Add the toView to the container
//    UIView* containerView = [transitionContext containerView];
//    [containerView addSubview:toView];
//    [containerView sendSubviewToBack:toView];
//
//    // animate
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration animations:^{
//        fromView.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        if ([transitionContext transitionWasCancelled]) {
//            fromView.alpha = 1.0;
//        } else {
//            // reset from- view to its original state
//            [fromView removeFromSuperview];
//            fromView.alpha = 1.0;
//        }
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
//
//    //    [self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
//}


//- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    self.transitionContext = transitionContext;
//    //self.transitionContext.isInteractive = YES;
//
//}

- (void)handleLeftEdgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer*)gc {
    switch (gc.state) {
        case UIGestureRecognizerStatePossible: {
            break;
        }
        case UIGestureRecognizerStateFailed: {
            break;
        }
        case UIGestureRecognizerStateBegan: {
            //GfitHorizontalEdgePanPercentDrivenInteractiveTransition * __weak weakSelf = self;
            //[self.operationQueue addOperationWithBlock:^{
            //  dispatch_async(dispatch_get_main_queue(), ^{
            //        GfitHorizontalEdgePanPercentDrivenInteractiveTransition *strongSelf = weakSelf;

                    if ([self.delegate respondsToSelector:@selector(horizontalLeftEdgePanInteractiveTransitionStart)]) {
                        [self.delegate performSelector:@selector(horizontalLeftEdgePanInteractiveTransitionStart) withObject:nil];
                    }
                    self.statusBarWindow = GfitSBWindow;

                    self.statusBarWindow.layer.speed = 0.0;
                    self.statusBarWindowBeginTime = CACurrentMediaTime();
                    self.statusBarWindowEndTime = self.statusBarWindowBeginTime + [self duration];
                    self.statusBarWindow.layer.timeOffset = self.statusBarWindowBeginTime;
            //  });
            //}];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            GfitHorizontalEdgePanPercentDrivenInteractiveTransition * __weak weakSelf = self;
            [self.operationQueue addOperationWithBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    GfitHorizontalEdgePanPercentDrivenInteractiveTransition *strongSelf = weakSelf;

                CGFloat percent = [gc translationInView:gc.view].x / CGRectGetWidth(gc.view.bounds);
                percent = fmin(fmax(0.0, percent), .99);
                DLogCGFloat(percent);
                [strongSelf updateInteractiveTransition:percent];
                strongSelf.statusBarWindow.layer.timeOffset = strongSelf.statusBarWindowBeginTime + ([strongSelf duration] * percent);
                });
            }];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = [gc translationInView:gc.view].x / CGRectGetWidth(gc.view.bounds);
            percent = fmin(fmax(0.0, percent), .99);


            DLogCGFloat([gc velocityInView:gc.view].x);
            DLogCGFloat(percent);

            if ([gc velocityInView:gc.view].x < kGfitVelocityThreshold && percent < kGfitGestureThreshold) {
            //if (gc.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
                //self.statusBarWindow.layer.speed = -1.0;
//                self.statusBarWindow.layer.speed = 1.0;
//                self.statusBarWindow.layer.autoreverses = YES;
//                self.statusBarWindow.layer.repeatCount = 2;
//                self.statusBarWindow.layer.duration = .5;
//                self.statusBarWindow.layer.repeatDuration = .5;

//                self.cancelledTransition = YES;
//                NSNumber *currentTime = [NSNumber numberWithFloat:self.statusBarWindow.layer.timeOffset];
//                CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"timeOffset"];
//                anim.fromValue = currentTime;
//                anim.toValue = [NSNumber numberWithFloat:self.statusBarDisplayLinkBeginTimestamp];
//                [self.statusBarWindow.layer addAnimation:anim forKey:@"timeOffset"];
//                anim.delegate = self;

                //self.statusBarAnimation = anim;
                //self.statusBarWindow.layer.timeOffset = self.statusBarWindowEndTime;

            } else {
                [self finishInteractiveTransition];

                self.cancelledTransition = NO;
                self.statusBarWindow.layer.speed = 1.0;
            self.statusBarWindow = nil;
            }


            DLogfloat(percent);

//
//            [self.displayLink invalidate];
//            self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateStatusBarDisplay:)];
//            [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//            self.statusBarWindowPercentComplete = percent;
//            self.statusBarDisplayLinkBeginTimestamp = CACurrentMediaTime();
//            self.statusBarDisplayLinkEndTimestamp = CACurrentMediaTime() + [self duration];
//            DLogfloat(self.statusBarDisplayLinkBeginTimestamp);
//            DLogfloat(self.statusBarDisplayLinkEndTimestamp);
            //self.displayLink.duration = [self duration] * (1 - percent);
            //self.statusBarWindow.layer.speed = 1.0;
            //self.statusBarWindow.layer.autoreverses = YES;
            //self.statusBarWindow.layer.repeatCount = 1;
            //self.statusBarWindow.layer.duration = [self duration] * (1 - percent);
            //self.statusBarWindow.layer.speed = 1.0;
            self.statusBarWindow = nil;
            //[self.delegate performSelector:@selector(setNeedsStatusBarAppearanceUpdate) withObject:nil];
            break;
        }
    }
}

- (void)handleRightEdgePanGestureRecognizer:(GfitHorizontalRightEdgePanGestureRecognizer*)gc {
    switch (gc.state) {
        case UIGestureRecognizerStatePossible: {
            break;
        }
        case UIGestureRecognizerStateFailed: {
            break;
        }
        case UIGestureRecognizerStateBegan: {
            //GfitHorizontalEdgePanPercentDrivenInteractiveTransition * __weak weakSelf = self;
            //[self.operationQueue addOperationWithBlock:^{
            //dispatch_async(dispatch_get_main_queue(), ^{
            //      GfitHorizontalEdgePanPercentDrivenInteractiveTransition *strongSelf = weakSelf;

                    if ([self.delegate respondsToSelector:@selector(horizontalRightEdgePanInteractiveTransitionStart)]) {
                        [self.delegate performSelector:@selector(horizontalRightEdgePanInteractiveTransitionStart) withObject:nil];
                    }
                    self.statusBarWindow = GfitSBWindow;

                    self.statusBarWindow.layer.speed = 0.0;
                    self.statusBarWindowBeginTime = CACurrentMediaTime();
                    self.statusBarWindowEndTime = self.statusBarWindowBeginTime + [self duration];
                    self.statusBarWindow.layer.timeOffset = self.statusBarWindowBeginTime;

            //  });
            //}];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            GfitHorizontalEdgePanPercentDrivenInteractiveTransition * __weak weakSelf = self;
            [self.operationQueue addOperationWithBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    GfitHorizontalEdgePanPercentDrivenInteractiveTransition *strongSelf = weakSelf;

                    CGFloat percent = fabs([gc translationInView:gc.view].x) / CGRectGetWidth(gc.view.bounds);
                    percent = fmin(fmax(0.0, percent), .99);
                    [strongSelf updateInteractiveTransition:percent];
                    strongSelf.statusBarWindow.layer.timeOffset = strongSelf.statusBarWindowBeginTime + ([strongSelf duration] * percent);
                });
            }];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = fabs([gc translationInView:gc.view].x) / CGRectGetWidth(gc.view.bounds);
            percent = fmin(fmax(0.0, percent), .99);


            DLogCGFloat([gc velocityInView:gc.view].x);
            DLogCGFloat(percent);

            if (fabs([gc velocityInView:gc.view].x) < kGfitVelocityThreshold && percent < kGfitGestureThreshold) {
            //if (gc.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
                //self.statusBarWindow.layer.speed = 1.0;
                //self.statusBarWindow.layer.speed = 1 - percent;
                DLogFunctionLine();

//                NSNumber *currentTime = [NSNumber numberWithFloat:self.statusBarWindow.layer.timeOffset];
//                CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"timeOffset"];
//                anim.fromValue = currentTime;
//                anim.toValue = [NSNumber numberWithFloat:self.statusBarDisplayLinkBeginTimestamp];
//                [self.statusBarWindow.layer addAnimation:anim forKey:@"timeOffset"];
////                self.statusBarAnimation = anim;
//                anim.delegate = self;

                //self.statusBarWindow.layer.speed = 1.0;
                //self.statusBarWindow.layer.repeatCount = 1;
                //self.statusBarWindow.layer.autoreverses = YES;
                //self.statusBarWindow.layer.repeatDuration = 5;
//                self.statusBarWindow.layer.speed = 1.0;
//                self.statusBarWindow.layer.autoreverses = YES;
//                self.statusBarWindow.layer.repeatCount = 2;
//                self.statusBarWindow.layer.duration = .5;
//                self.statusBarWindow.layer.repeatDuration = .5;
                self.cancelledTransition = YES;

            } else {
                [self finishInteractiveTransition];
                self.statusBarWindow.layer.speed = 1.0;
                //self.statusBarWindow.layer.speed = 1.0;
                //self.statusBarWindow.layer.speed = 1.0;
                self.statusBarWindow = nil;

            }
            self.statusBarWindow = nil;
            //self.statusBarWindow.layer.speed = 1.0;

            //self.statusBarWindow.la
            DLogfloat(percent);
            //[self.displayLink invalidate];
            //self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateStatusBarDisplay:)];
            //[self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//            self.statusBarWindowPercentComplete = percent;
//            self.statusBarDisplayLinkBeginTimestamp = CACurrentMediaTime();
//            self.statusBarDisplayLinkEndTimestamp = CACurrentMediaTime() + [self duration];
//            DLogfloat(self.statusBarDisplayLinkBeginTimestamp);
//            DLogfloat(self.statusBarDisplayLinkEndTimestamp);
            //self.displayLink.duration = [self duration] * (1 - percent);
            //self.statusBarWindow.layer.speed = 1.0;
            //self.statusBarWindow.layer.autoreverses = YES;
            //self.statusBarWindow.layer.repeatCount = 1;

            //self.statusBarWindow.layer.duration = [self duration] * (1 - percent);
            //self.statusBarWindow = nil;
            //self.statusBarWindow.layer.duration = 5;

            DLogfloat(self.statusBarWindow.layer.beginTime);
            break;
        }
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    anim.delegate = nil;
    self.statusBarWindow.layer.speed = 1.0;
    self.statusBarWindow = nil;
    [self.delegate performSelector:@selector(setNeedsStatusBarAppearanceUpdate) withObject:nil];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    DLogObject(gestureRecognizer);
    DLogObject(otherGestureRecognizer);
    return YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer == self.leftEdgePanGestureRecognizer || otherGestureRecognizer == self.rightEdgePanGestureRecognizer) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.leftEdgePanGestureRecognizer || gestureRecognizer == self.rightEdgePanGestureRecognizer) {
        return YES;
    }
    return NO;
}

//- (void)teardownDisplayLink {
//    //self.statusBarWindow = nil;
//    //[self.displayLink invalidate];
//    //self.displayLink = nil;
//}

@end
