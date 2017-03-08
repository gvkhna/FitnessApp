//
//  GfitHorizontalSlidingTabBarController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/7/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitHorizontalSlidingTabBarController.h"
#import "GfitMainMenuViewController.h"
#import "GfitMainMenuNavigationController.h"
#import "GfitContentNavigationController.h"
#import "GfitSerialOperationQueue.h"
#import "GfitRootNavigationDropShadowView.h"
#import "GfitFakeNavigationBar.h"
#import "GfitHorizontalEdgePanPercentDrivenInteractiveTransition.h"
#import "GfitHorizontalEdgePanPercentDrivenInteractiveTransitionProtocol.h"
#import "UIWindow+SBWindow.h"
#import "GfitMainMenuSearchInteractiveTransition.h"
#import "GfitContentNavigationBar.h"
#import <objc/runtime.h>

@interface GfitHorizontalSlidingTabBarController () <UITabBarControllerDelegate, GfitContentNavigationViewControllerDelegateProtocol, UIViewControllerAnimatedTransitioning, GfitHorizontalEdgePanPercentDrivenInteractiveTransitionProtocol, GfitHorizontalSlidingTabBarDelegateProtocol>

@property (nonatomic, strong) GfitHorizontalEdgePanPercentDrivenInteractiveTransition *edgePanInteractiveTransition;
@property (nonatomic, strong) GfitSerialOperationQueue *operationQueue;

@property (nonatomic, weak) GfitMainMenuNavigationController *mainMenuNavigation;
@property (nonatomic, weak) GfitContentNavigationController *contentNavigation;
@property (nonatomic, strong) GfitMainMenuSearchInteractiveTransition *searchInteractiveTransitionDelegate;

@property (nonatomic, weak) UIViewController *fakeRootController;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitioningContext;

@property (nonatomic, assign) BOOL presentingContentNavigation;
@property (nonatomic, assign) BOOL presentingContentNavigationInteractively;

@property (nonatomic, strong) UIWindow *statusBarWindow;

@property (nonatomic, strong) UIView *mainMenuNavigationSnapshotView;
@property (nonatomic, strong) UIView *contentNavigtionSnapshotView;

@end

@implementation GfitHorizontalSlidingTabBarController

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tabBar setHidden:YES];

	// Do any additional setup after loading the view.
    GfitMainMenuViewController *mainMenuController = [[GfitMainMenuViewController alloc] initWithNibName:nil bundle:nil];
    mainMenuController.horizontalSlidingDelegate = self;

    GfitMainMenuNavigationController *mainMenuNavigation = [[GfitMainMenuNavigationController alloc] initWithRootViewController:mainMenuController];
    self.searchInteractiveTransitionDelegate = [[GfitMainMenuSearchInteractiveTransition alloc] initWithParentViewController:mainMenuController];
    mainMenuNavigation.delegate = self.searchInteractiveTransitionDelegate;
    mainMenuNavigation.interactivePopGestureRecognizer.enabled = NO;

    UIViewController *fakeRootController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    //GfitContentNavigationController *contentNavigation = [[GfitContentNavigationController alloc] initWithNavigationBarClass:[GfitContentNavigationBar class] toolbarClass:nil];
    //[contentNavigation setViewControllers:@[fakeRootController]];
    GfitContentNavigationController *contentNavigation = [[GfitContentNavigationController alloc] initWithRootViewController:fakeRootController];
    contentNavigation.interactivePopGestureRecognizer.enabled = NO;
    contentNavigation.contentNavigationDelegate = self;

    self.mainMenuNavigation = mainMenuNavigation;
    self.contentNavigation = contentNavigation;
    self.fakeRootController = fakeRootController;

    [self setViewControllers:@[mainMenuNavigation, contentNavigation] animated:NO];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.operationQueue = [[GfitSerialOperationQueue alloc] init];
    self.edgePanInteractiveTransition = [[GfitHorizontalEdgePanPercentDrivenInteractiveTransition alloc] initWithDelegate:self];

    self.delegate = self;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;
    self.delegate = nil;
}

- (void)horizontalLeftEdgePanInteractiveTransitionStart {
    self.presentingContentNavigationInteractively = YES;
    [self backToMainMenu:nil];
}

- (void)horizontalRightEdgePanInteractiveTransitionStart {
    self.presentingContentNavigationInteractively = YES;
    NSBlockOperation *blockOperation = [NSBlockOperation new];
    @weakify(blockOperation);
    @weakify(self);
    [blockOperation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{

            @strongify(self);

            if ([blockOperation_weak_ isCancelled]) {
                return;
            }

            [self pushToContentNavigation:nil];

        });
    }];
    [self.operationQueue addOperation:blockOperation];
}

- (void)pushToViewController:(UIViewController *)viewController {

    NSBlockOperation *blockOperation = [NSBlockOperation new];
    @weakify(blockOperation);
    @weakify(self);
    [blockOperation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{

            @strongify(self);

            if ([blockOperation_weak_ isCancelled]) {
                return;
            }

            Class currentClass = self.contentNavigation.topViewController.class;
            Class newClass = viewController.class;

            const char *n1 = class_getName(currentClass);
            const char *n2 = class_getName(newClass);

            // if already showing the viewController, just skip to presenting
            if (strcmp(n1, n2) == 0) {

            } else {
                UIViewController *fakeRootController = self.fakeRootController;
                fakeRootController.title = self.mainMenuNavigation.topViewController.title;
                [self.contentNavigation setViewControllers:@[fakeRootController, viewController] animated:NO];
            }

            [self pushToContentNavigation:nil];

        });
    }];
    [self.operationQueue addOperation:blockOperation];
}

- (void)pushToContentNavigation:(id)sender {

    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    @weakify(operation);
    @weakify(self);
    [operation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //@strongify(self);

            if ([operation_weak_ isCancelled]) {
                return;
            }

            [UIView animateWithDuration:[self transitionDuration:nil]
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 //@strongify(self);

                                 [self_weak_ setSelectedIndex:1];
                             } completion:^(BOOL finished) {
                                 if (finished) {

                                 }
                             }];
            
        });
    }];
    [self.operationQueue addOperation:operation];
}

- (void)backToMainMenu:(id)sender {

    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    @weakify(operation);
    @weakify(self);
    [operation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);

            if ([operation_weak_ isCancelled]) {
                return;
            }

            [UIView animateWithDuration:[self transitionDuration:nil]
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 @strongify(self);

                                 [self setSelectedIndex:0];
                             } completion:^(BOOL finished) {
                                 if (finished) {

                                 }
                             }];

        });
    }];
    [self.operationQueue addOperation:operation];

}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    self.presentingContentNavigation = (fromVC == self.mainMenuNavigation);
    return self;
    
    
}

- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                      interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    if (self.presentingContentNavigationInteractively) {
        return self.edgePanInteractiveTransition;
    }
    return nil;
}


#pragma mark - UIViewController animated transitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> )transitionContext {
	//return 5.0f;
	return 0.35f;
	//return 1.0f;
}

/**
 *  Delegate method for the fake navigation bar we present during animation
 *
 *  @param bar the `UINavigationBar` object
 *
 *  @return the `UIBarPosition` style
 */
- (UIBarPosition)positionForBar:(id <UIBarPositioning> )bar {
	return UIBarPositionTopAttached;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning> )transitionContext {
	@autoreleasepool {
		// okay here's the plan, we're going to setup a plan, reverse it if necessary, then execute

		/**
		 *  setup
		 */

		// get view controllers
		UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
		UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

		// create animation start/end values
		const CGRect bounds = fromVC.view.bounds;
		const CGFloat width = CGRectGetWidth(bounds);
		static const CGFloat kSlidingOffset = 96.0f; // constant offset value for view sliding underneath
		static const CGFloat kNavigationBarHeight = 64.0f;

		const CGRect viewOnScreenFrame = bounds; // view onscreen
		const CGRect newViewOffscreenFrame = CGRectOffset(bounds, width, 0); // new view offscreen
		const CGRect viewSlidingOffscreenFrame = CGRectOffset(bounds, -(kSlidingOffset), 0);  // view slid offscreen

		// create setup interface variables (these are same regardless of present/dismiss)
		UIView *containerView = [transitionContext containerView];
		//NSString *navControllerFromViewControllerTitle = fromVC.title;
        UIViewController *topViewController = self.contentNavigation.topViewController;
		NSString *navControllerTopViewControllerTitle = topViewController.title;
        NSArray *contentNavigationViewControllers = self.contentNavigation.viewControllers;
        NSString *navControllerBackViewControllerTitle = nil;
        // if pushed past 2 controllers this will have to use the back button already there
        NSUInteger topViewControllerIndex = [contentNavigationViewControllers indexOfObject:topViewController];
        if ([contentNavigationViewControllers count] > 1) {
            // it is pushed past 2 controllers
            id previousViewController = [contentNavigationViewControllers objectAtIndex:topViewControllerIndex-1];
            if (previousViewController && [previousViewController respondsToSelector:@selector(title)]) {
                  navControllerBackViewControllerTitle = [previousViewController performSelector:@selector(title) withObject:nil];
            }
        } else {
            // it's not pushed past, just grab the main menu
            navControllerBackViewControllerTitle = [self.mainMenuNavigation.title copy];
        }

		GfitFakeNavigationBar *fakeNavigationBar;
		GfitRootNavigationDropShadowView *dropShadowView;

		// create animation fake auxiliary assets

		// container view for front most view
		dropShadowView = [[GfitRootNavigationDropShadowView alloc] initWithFrame:bounds];
		// this should be set to the target views background color
		dropShadowView.backgroundColor = [UIColor whiteColor]; // nav bar is translucent, black bg will show through
		dropShadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

		// fake the navigation bar item transition push/pop
		fakeNavigationBar = [[GfitFakeNavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, kNavigationBarHeight)];
		fakeNavigationBar.delegate = self;


		// hide the real navigation bar for faking transition
		// HACK: setting navigationBarHidden on the `UINavigationController`
		// casues the status bar fade to no longer be animated
		// setting the layer navigationBar's layer seems to work
		//
		// @note this also has to be called after the navigationViewController's
		// snapshot is taken after updates
		//
		// @note setting the navigationBar.layer.hidden causes layout to change
		// @note setting opacity or alpha doesn't work for some reason
		// setting the zPosition accomplishes our goals perfectly
		// we just want to get it out of the way for the snapshot so
		// we can add our own fake navigation bar on top without an incorrect layout
		self.contentNavigation.navigationBar.layer.zPosition = -100;

		/**
		 *  these are the plan variables, these get loaded with appropriate values
		 */

		// plan variables for views (reversed on dismiss animation)
		UIView *fromView;
		UIView *toView;

		// plan variables for navigation items (push/pop for present/dismiss)
		UINavigationItem *fromNavigationItem;
		UINavigationItem *toNavigationItem;

		// plan variables for rect (reversed on dismiss animation)
		CGRect fromViewStartFrame;
		CGRect toViewStartFrame;
		CGRect fromViewEndFrame;
		CGRect toViewEndFrame;

		//self.navigationViewController.edgesForExtendedLayout = UIRectEdgeBottom;

		/**
		 *  Here's the reversal if necessary
		 */

		if (self.presentingContentNavigation) {
			fromView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
			fromView.layer.shouldRasterize = YES;
			fromView.layer.drawsAsynchronously = YES;
			fromView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            fromView.opaque = YES;
            self.mainMenuNavigationSnapshotView = fromView;

			toView = dropShadowView;

			fromNavigationItem = [[UINavigationItem alloc] initWithTitle:navControllerBackViewControllerTitle];
			toNavigationItem = [[UINavigationItem alloc] initWithTitle:navControllerTopViewControllerTitle];

			// sending NO causes the navigation controllers contents to be missing
			// sending YES causes the childViewControllerForStatusBarStyle to be called early
			// and for the change to be instant instead of animated
            UIView *snapshotView;
            if (self.contentNavigtionSnapshotView) {
                snapshotView = self.contentNavigtionSnapshotView;
            } else {
                snapshotView = [self.contentNavigation.view snapshotViewAfterScreenUpdates:YES];
                self.contentNavigtionSnapshotView = snapshotView;
            }
			snapshotView.opaque = YES;
			snapshotView.layer.drawsAsynchronously = YES;
			snapshotView.layer.shouldRasterize = YES;
			snapshotView.layer.rasterizationScale = [UIScreen mainScreen].scale;

			[dropShadowView addSubview:snapshotView];
			[containerView addSubview:fromView];
			[containerView addSubview:toView];

			fromViewStartFrame = viewOnScreenFrame;
			toViewStartFrame = newViewOffscreenFrame;
			fromViewEndFrame = viewSlidingOffscreenFrame;
			toViewEndFrame = viewOnScreenFrame;
		} else {
            if (self.mainMenuNavigationSnapshotView) {
                toView = self.mainMenuNavigationSnapshotView;
            } else {
                toView = [self.mainMenuNavigation.view snapshotViewAfterScreenUpdates:YES];
                self.mainMenuNavigationSnapshotView = toView;
            }
            toView.layer.drawsAsynchronously = YES;
            toView.layer.shouldRasterize = YES;
            toView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            toView.opaque = YES;
			fromView = dropShadowView;

			fromNavigationItem = [[UINavigationItem alloc] initWithTitle:navControllerBackViewControllerTitle];
			toNavigationItem = [[UINavigationItem alloc] initWithTitle:navControllerTopViewControllerTitle];

			UIView *snapshotView = [self.contentNavigation.view snapshotViewAfterScreenUpdates:NO];

			snapshotView.opaque = YES;
			snapshotView.layer.shouldRasterize = YES;
			snapshotView.layer.drawsAsynchronously = YES;
			snapshotView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            self.contentNavigtionSnapshotView = snapshotView;
            
			[dropShadowView addSubview:snapshotView];
			[containerView addSubview:toView];
			[containerView addSubview:fromView];

			fromViewStartFrame = viewOnScreenFrame;
			toViewStartFrame = viewSlidingOffscreenFrame;
			fromViewEndFrame = newViewOffscreenFrame;
			toViewEndFrame = viewOnScreenFrame;
		}


		/**
		 *  Setup the animation initial state
		 */
		fromView.frame = fromViewStartFrame;
		toView.frame = toViewStartFrame;

		// setup the drop shadow animation
		[dropShadowView addSubview:fakeNavigationBar];
		dropShadowView.shadowImageView.alpha = 1.0;

		// required for navigationBar title labels to be in proper places
		// we basically layout both possible states
		[fakeNavigationBar setItems:@[fromNavigationItem] animated:NO];
		[fakeNavigationBar setNeedsLayout];
		[fakeNavigationBar layoutIfNeeded];
		[fakeNavigationBar setItems:@[fromNavigationItem, toNavigationItem] animated:NO];
		[fakeNavigationBar setNeedsLayout];
		[fakeNavigationBar layoutIfNeeded];

		// if reverse animation we're going to animate the pop, otherwise
		// pop it unanimated now to get it ready for the animation start
		if (self.presentingContentNavigation) {
			[fakeNavigationBar popNavigationItemAnimated:NO];
		} else {

		}

		//GfitHorizontalSlidingTabBarController *__weak weakSelf = self;
        @weakify(self);

		[UIView animateWithDuration:[self transitionDuration:transitionContext]
		                      delay:0
		                    options:UIViewAnimationOptionAllowAnimatedContent
		                 animations: ^{
                             /**
                              *  Run the animation
                              */
                             //GfitHorizontalSlidingTabBarController *strongSelf = weakSelf;
                             @strongify(self);

                             fromView.frame = fromViewEndFrame;
                             toView.frame = toViewEndFrame;

                             // animate the drop shadow
                             dropShadowView.shadowImageView.alpha = 0.0;

                             // animate the navigation bar transition
                             if (self.presentingContentNavigation) {
                                 [fakeNavigationBar pushNavigationItem:toNavigationItem animated:YES];
                             } else {
                                 [fakeNavigationBar popNavigationItemAnimated:YES];
                             }
                         } completion: ^(BOOL finished) {
                             @autoreleasepool {
                                 if (finished) {
                                     /**
                                      *  Undo animation initial state
                                      */
                                     //GfitHorizontalSlidingTabBarController *strongSelf = weakSelf;
                                     @strongify(self);

                                     // remove fake assets
                                     [fromView removeFromSuperview];
                                     [toView removeFromSuperview];
                                     [dropShadowView removeFromSuperview];
                                     [fakeNavigationBar removeFromSuperview];
                                     [self.contentNavigation.snapshotView removeFromSuperview];
                                     self.contentNavigation.snapshotView = nil;

                                     // switch back to the the real navigation bar
                                     self.contentNavigation.navigationBar.layer.zPosition = self.contentNavigation.originalNavigationBarZPosition;

                                     // interactive animation might cancel
                                     if ([transitionContext transitionWasCancelled]) {
                                         // animation cancel
                                         fromView.frame = fromViewStartFrame;
                                         toView.frame = toViewStartFrame;

                                        [containerView addSubview:fromVC.view];

                                     } else {
                                         // animation completion
                                         fromView.frame = fromViewEndFrame;
                                         toView.frame = toViewEndFrame;

                                         [containerView addSubview:toVC.view];


                                     }
                                     
                                     [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                 }
                             }
                         }];
	}
}

- (void)animationEnded:(BOOL)transitionCompleted {

    self.presentingContentNavigationInteractively = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.edgePanInteractiveTransition teardownLeftEdgePanGestureRecognizer];
    [self.edgePanInteractiveTransition teardownRightEdgePanGestureRecognizer];
    if (self.selectedIndex == 0) {
        if ([self.contentNavigation.viewControllers count] > 1) {
            [self.edgePanInteractiveTransition setupRightEdgePanGestureRecognizer];
        }
    } else {
        [self.edgePanInteractiveTransition setupLeftEdgePanGestureRecognizer];
    }
}


@end
