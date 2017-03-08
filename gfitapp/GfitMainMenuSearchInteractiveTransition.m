//
//  GfitMainMenuSearchInteractiveTransition.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuSearchInteractiveTransition.h"
#import "GfitSearchPanGestureRecognizer.h"
#import "GfitSearchButtonView.h"
#import "GfitMainMenuDynamicAnimator.h"
#import "gfitapp-Constants.h"
#import <tgmath.h>

@interface GfitMainMenuSearchInteractiveTransition () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) GfitSearchPanGestureRecognizer *searchPanGestureRecognizer;
@property (nonatomic, weak) id<GfitMainMenuSearchInteractiveTransitionProtocol> parent;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) BOOL presentingSearch;
@property (nonatomic, strong) UIView *hueViewControllerSnapshot;
@property (nonatomic, strong) UIView *searchDraggableViewSnapshot;
@property (nonatomic, strong) GfitMainMenuDynamicAnimator *mainMenuDynamicAnimator;

@end

@implementation GfitMainMenuSearchInteractiveTransition

- (instancetype)initWithParentViewController:(id<GfitMainMenuSearchInteractiveTransitionProtocol>)viewController {
    self = [super init];
    if (self) {
        @autoreleasepool {
            _parent = viewController;


            _searchPanGestureRecognizer = [[GfitSearchPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSearchPanGesture:)];
            //_searchPanGestureRecognizer.delegate = self;

            UIViewController<GfitMainMenuDynamicAnimatorProtocol> *parentVC = (UIViewController<GfitMainMenuDynamicAnimatorProtocol>*)_parent;
            _mainMenuDynamicAnimator = [[GfitMainMenuDynamicAnimator alloc] initWithParent:parentVC];
            UIView *parentView;
            if ([_parent respondsToSelector:@selector(view)]) {
                parentView = [_parent performSelector:@selector(view) withObject:nil];
                [parentView addGestureRecognizer:_searchPanGestureRecognizer];
            }
        }
    }
    return self;
}

- (void)handleSearchPanGesture:(GfitSearchPanGestureRecognizer *)gc {
    CGPoint location = [gc locationInView:gc.view];
	location.x = CGRectGetMidX(gc.view.bounds);

    switch (gc.state) {
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateFailed: {

            break;
        }
        case UIGestureRecognizerStateBegan: {
            self.interactive = YES;

            [self.mainMenuDynamicAnimator setupSearchGesture];
            [self.mainMenuDynamicAnimator setupSearchGestureAttachmentToLocation:location];

//            if ([self.parent respondsToSelector:@selector(search:)]) {
//                [self.parent performSelector:@selector(search:) withObject:nil];
//            }

            //GfitSearchViewController *searchController = [[GfitSearchViewController alloc] initWithNibName:nil bundle:nil];
            //searchController.transitioningDelegate = self.parent;
//            [self.parent presentViewController:searchController animated:YES completion:^{
//
//            }];

//            self.parent.presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
//            self.parent.presentedViewController.transitioningDelegate = self.parent;
//            [self.parent dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {

            CGFloat percent = [gc locationInView:gc.view].y / CGRectGetHeight(gc.view.frame);
            percent = fmin(fmax(0.0, percent), .99);

            [self.mainMenuDynamicAnimator updateGestureAttachmentToLocation:location];

            //[self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateRecognized: {
            //[self finishInteractiveTransition];
//            BOOL recognized = (gc.state == UIGestureRecognizerStateRecognized);
//
//            [self.mainMenuDynamicAnimator detachGestureAttachment];
//
//			if (recognized) {
//				//[self _showSearch:YES];
//			} else {
//				//[self _showSearch:NO];
//			}
//            self.interactive = NO;
            [self gestureRecognizerEndedGesture:gc];
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            //[self cancelInteractiveTransition];
//            self.interactive = NO;
            [self gestureRecognizerEndedGesture:gc];
            break;
        }
    }
}

- (void)gestureRecognizerEndedGesture:(GfitSearchPanGestureRecognizer*)gc {
    BOOL recognized = (gc.state == UIGestureRecognizerStateRecognized);

    [self.mainMenuDynamicAnimator detachGestureAttachment];

    if (recognized) {
//        if ([self.parent respondsToSelector:@selector(_showSearch:)]) {
//            [self.parent performSelector:@selector(_showSearch:) withObject:[NSNumber numberWithBool:YES]];
//        }
        
        if ([self.parent respondsToSelector:@selector(search:)]) {
            [self.parent performSelector:@selector(search:) withObject:nil];
        }
        //[self _showSearch:YES];
    } else {
//        if ([self.parent respondsToSelector:@selector(_showSearch:)]) {
//            [self.parent performSelector:@selector(_showSearch:) withObject:[NSNumber numberWithBool:NO]];
//        }
        GfitMainMenuSearchInteractiveTransition * __weak weakSelf = self;
        [self.mainMenuDynamicAnimator setupSearchGestureFinishTransition:NO completion:[NSBlockOperation blockOperationWithBlock:^{
            [weakSelf.mainMenuDynamicAnimator teardownDynamicAnimator];
        }]];
        //[self _showSearch:NO];
        if ([self.parent respondsToSelector:@selector(searchCancel:)]) {
            [self.parent performSelector:@selector(searchCancel:) withObject:nil];
        }
    }

    self.interactive = NO;
}

//- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    self.transitionContext = transitionContext;
//}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    //return 10.0;
    //return 1.0;
     return 0.35;
    //return kGfitTransitionFastTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIViewController *mainMenuController = self.presentingSearch ? fromController : toController;
    UIViewController *searchController = self.presentingSearch ? toController : fromController;

    [containerView addSubview:fromController.view];
    [containerView addSubview:toController.view];

    CGRect fromFrame = containerView.bounds;
//    CGRect toFrame = fromFrame;
//    toFrame.origin.y = -toFrame.size.height;


    [fromController.view setFrame:fromFrame];
    [toController.view setFrame:fromFrame];

    containerView.backgroundColor = [UIColor whiteColor];

    UIView *snapshotView;
    UIView *searchView;
    UIImageView *searchBackgroundImageView;
    UIImageView *transitionSearchBackgroundImageView;
    UIView *parentView;
    UIView *searchDraggableView;
    UIView *scanButtonView;
    UIView *searchTableView;
    UIView *searchCancelButton;
    UIView *searchButtonView;
    UITextField *searchTextField;

    CGRect hueViewControllerSnapshotFrame;

    CGRect searchDraggableBeforeFrame;
    CGRect searchDraggableAfterFrame;

    CGRect searchTextFieldBeforeFrame;
    CGRect searchTextFieldAfterFrame;

    CGRect searchTableViewBeforeFrame;
    CGRect searchTableViewAfterFrame;

    CGRect searchCancelButtonBeforeFrame;
    CGRect searchCancelButtonAfterFrame;


    if ([self.parent respondsToSelector:@selector(hueViewController)]) {
        UIViewController *hueViewController = [mainMenuController performSelector:@selector(hueViewController) withObject:nil];
        if (self.hueViewControllerSnapshot && !self.presentingSearch) {
            [containerView addSubview:self.hueViewControllerSnapshot];
        } else {
            snapshotView = [hueViewController.view snapshotViewAfterScreenUpdates:NO];
            snapshotView.layer.shouldRasterize = YES;
            snapshotView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            snapshotView.opaque = YES;
            snapshotView.layer.drawsAsynchronously = YES;
            [containerView addSubview:snapshotView];
            self.hueViewControllerSnapshot = snapshotView;
        }
        hueViewControllerSnapshotFrame = hueViewController.view.frame;
        hueViewControllerSnapshotFrame.origin.y = hueViewController.topLayoutGuide.length;
        self.hueViewControllerSnapshot.frame = hueViewControllerSnapshotFrame;
    }

    if ([searchController respondsToSelector:@selector(view)]) {
        searchView = [searchController performSelector:@selector(view) withObject:nil];
        if ([searchView respondsToSelector:@selector(searchViewBackgroundImageView)]) {
            searchBackgroundImageView = [searchView performSelector:@selector(searchViewBackgroundImageView)];
            searchBackgroundImageView.alpha = 0;
            transitionSearchBackgroundImageView = [[UIImageView alloc] initWithImage:searchBackgroundImageView.image];


            [containerView addSubview:transitionSearchBackgroundImageView];

        }
        if ([searchView respondsToSelector:@selector(searchTableViewController)]) {
            UIViewController *tableController = [searchView performSelector:@selector(searchTableViewController)];
            UIView *tableView = [tableController performSelector:@selector(view)];
            searchTableView = tableView;
        }
    }

    searchView.backgroundColor = [UIColor clearColor];

    if ([mainMenuController respondsToSelector:@selector(view)]) {
        parentView = [mainMenuController performSelector:@selector(view)];
        if ([parentView respondsToSelector:@selector(searchDraggableView)]) {
            UIView *view = [parentView performSelector:@selector(searchDraggableView)];

            if ([view respondsToSelector:@selector(searchButtonView)]) {
                searchButtonView = [view performSelector:@selector(searchButtonView)];
                searchButtonView.alpha = 0;
                //[[searchButtonView superview] setNeedsDisplay];
            }

            if ([view respondsToSelector:@selector(scanButtonView)]) {
                scanButtonView = [view performSelector:@selector(scanButtonView)];
            }

            if (self.searchDraggableViewSnapshot && !self.presentingSearch) {
                //searchDraggableView = self.searchDraggableViewSnapshot;


            } else {
                UIView *snapshotView = [view snapshotViewAfterScreenUpdates:NO];
                snapshotView.layer.shouldRasterize = YES;
                snapshotView.layer.rasterizationScale = [UIScreen mainScreen].scale;
                snapshotView.opaque = YES;
                snapshotView.layer.drawsAsynchronously = YES;
                snapshotView.layer.masksToBounds = YES;

//                CGFloat maskTopMargin = searchButtonView.frame.size.height;
//
//                CGRect frame = CGRectMake(0, maskTopMargin, CGRectGetWidth(containerView.bounds), CGRectGetHeight(containerView.bounds) - maskTopMargin);
//
//                CAShapeLayer *maskLayer = [CAShapeLayer new];
//                maskLayer.frame = frame;
//                //maskLayer.contentsScale = [UIScreen mainScreen].scale;
//                maskLayer.path = [UIBezierPath bezierPathWithRect:frame].CGPath;
//
//                snapshotView.layer.mask = maskLayer;
                self.searchDraggableViewSnapshot = snapshotView;
            }

            searchDraggableBeforeFrame = [view frame];
            CGRect searchDraggableBounds = [view bounds];
            CGPoint searchDraggableCenter = CGPointMake(round(searchDraggableBounds.size.width/2), round(searchDraggableBounds.size.height/2));
            view.center = searchDraggableCenter;

            if (!self.presentingSearch) {
                searchDraggableBeforeFrame = [view frame];
            }


            CAShapeLayer *maskLayer = [CAShapeLayer new];
            CGFloat maskTopMargin = (searchButtonView.frame.origin.y + searchButtonView.frame.size.height )/ [UIScreen mainScreen].scale;

            CGRect frame = CGRectMake(0, maskTopMargin, CGRectGetWidth(containerView.bounds), CGRectGetHeight(containerView.bounds) - maskTopMargin);

            //UIView *maskView = [[UIView alloc] initWithFrame:frame];
            //maskView.clipsToBounds = YES;
            //maskView.layer.masksToBounds = YES;
            //[maskView addSubview:self.searchDraggableViewSnapshot];
            //[containerView addSubview:maskView];
            //maskView.bounds = frame;

            CGRect snapshotFrame = self.searchDraggableViewSnapshot.frame;
            snapshotFrame.origin.y -= maskTopMargin;
            //self.searchDraggableViewSnapshot.frame = snapshotFrame;


            [containerView addSubview:self.searchDraggableViewSnapshot];

            // Create a mask layer and the frame to determine what will be visible in the view.


            // Create a path with the rectangle in it.
            CGPathRef path = CGPathCreateWithRect(frame, NULL);

            // Set the path to the mask layer.
            maskLayer.path = path;
            maskLayer.frame = frame;


            // Release the path since it's not covered by ARC.
            CGPathRelease(path);
            
            // Set the mask of the view.
            //viewToMask.layer.mask = maskLayer;
            self.searchDraggableViewSnapshot.layer.mask = maskLayer;

            searchDraggableView = view;
            searchDraggableView.alpha = 0;




            //self.searchDraggableViewSnapshot.bounds = frame;
            //[containerView addSubview:searchDraggableView];

            //searchDraggableView = view;
            //[containerView addSubview:searchDraggableView];
        }
    }

    if ([searchView respondsToSelector:@selector(searchTextFieldView)]) {
        searchTextField = [searchView performSelector:@selector(searchTextFieldView)];
        if ([searchTextField respondsToSelector:@selector(searchCancelButton)]) {
            searchCancelButton = [searchTextField performSelector:@selector(searchCancelButton)];

        }
    }

    [containerView bringSubviewToFront:searchController.view];
    [searchController.view setNeedsLayout];
    [searchController.view layoutIfNeeded];

    searchTableViewAfterFrame = searchTableView.frame;
    searchTableViewBeforeFrame = searchTableView.frame;
    searchTableViewBeforeFrame.origin.y += CGRectGetHeight(searchTableView.frame);

    searchCancelButtonAfterFrame = searchCancelButton.frame;
    searchCancelButtonBeforeFrame = searchCancelButton.frame;
    searchCancelButtonBeforeFrame.origin.x = CGRectGetWidth(searchTextField.bounds);

    if (self.presentingSearch) {
        self.searchDraggableViewSnapshot.alpha = 1;

        transitionSearchBackgroundImageView.alpha = 0;

        searchTableView.frame = searchTableViewBeforeFrame;

        searchCancelButton.frame = searchCancelButtonBeforeFrame;

    } else {

        self.searchDraggableViewSnapshot.alpha = 0;

        transitionSearchBackgroundImageView.alpha = 1;

        searchTableView.frame = searchTableViewAfterFrame;

        searchCancelButton.frame = searchCancelButtonAfterFrame;
    }

    searchDraggableAfterFrame = self.searchDraggableViewSnapshot.frame;
    //searchDraggableBeforeFrame = searchDraggableAfterFrame;
    //searchDraggableBeforeFrame.or

    searchTextFieldAfterFrame = searchTextField.frame;
    searchTextFieldBeforeFrame = searchTextField.frame;
    searchTextFieldBeforeFrame.origin.y += searchDraggableBeforeFrame.origin.y;

    //if (self.interactive) {
        //CGRect searchDragFrame = searchDraggableAfterFrame;
        //searchDragFrame.origin.y = searchDraggableBeforeFrame.origin.y;
        self.searchDraggableViewSnapshot.frame = searchDraggableBeforeFrame;

        //CGRect searchTextFieldDragFrame = searchTextField.frame;
        //searchTextFieldDragFrame.origin.y = searchDraggableBeforeFrame.origin.y;
        searchTextField.frame = searchTextFieldBeforeFrame;
        //}



    GfitMainMenuSearchInteractiveTransition * __weak weakSelf = self;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         GfitMainMenuSearchInteractiveTransition *strongSelf = weakSelf;

                         if (strongSelf.presentingSearch) {
                             strongSelf.searchDraggableViewSnapshot.alpha = 0;
                             transitionSearchBackgroundImageView.alpha = 1;

                             searchTableView.frame = searchTableViewAfterFrame;
                             searchCancelButton.frame = searchCancelButtonAfterFrame;
                         } else {
                             strongSelf.searchDraggableViewSnapshot.alpha = 1;
                             transitionSearchBackgroundImageView.alpha = 0;

                             searchTableView.frame = searchTableViewBeforeFrame;
                             searchCancelButton.frame = searchCancelButtonBeforeFrame;
                         }

                         //if (strongSelf.interactive) {
                             strongSelf.searchDraggableViewSnapshot.frame = searchDraggableAfterFrame;
                             searchTextField.frame = searchTextFieldAfterFrame;
                             //}

                     } completion:^(BOOL finished) {
                         if (finished) {
                             GfitMainMenuSearchInteractiveTransition *strongSelf = weakSelf;

                             //[searchDraggableView removeFromSuperview];
                             //[searchBackgroundImageView removeFromSuperview];
                             [transitionSearchBackgroundImageView removeFromSuperview];
                             //searchView.backgroundColor = [UIColor whiteColor];
                             //[snapshotView removeFromSuperview];
                             [strongSelf.hueViewControllerSnapshot removeFromSuperview];
                             [strongSelf.searchDraggableViewSnapshot removeFromSuperview];

                             searchButtonView.alpha = 1;

                             searchDraggableView.alpha = 1;

                             searchBackgroundImageView.alpha = 1;

                             [fromController.view removeFromSuperview];
                             [toController.view removeFromSuperview];
                             [containerView addSubview:fromController.view];
                             [containerView addSubview:toController.view];
                             toController.view.frame = containerView.bounds;

                             [toController.view setNeedsLayout];
                             [toController.view layoutIfNeeded];
                             [toController.view setNeedsDisplay];

                             //strongSelf.interactive = NO;
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }
                     }];
}

#pragma mark - Navigation View Controller transition

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
    animationControllerForOperation:(UINavigationControllerOperation)operation
    fromViewController:(UIViewController *)fromVC
    toViewController:(UIViewController *)toVC {

    if (operation == UINavigationControllerOperationPush) {
        self.presentingSearch = YES;
    } else {
        self.presentingSearch = NO;
    }

    DLogFunctionLine();

    return self;

}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
    interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (self.interactive) {
        return self;
    }
    return nil;
}


@end
