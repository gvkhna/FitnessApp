//
//  GfitMainMenuViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuViewController.h"
#import "GfitMainMenuView.h"
#import "GfitHueViewController.h"
#import "GfitMenuGridController.h"
#import "GfitMenuGridControllerDataSource.h"
#import "GfitCameraViewController.h"
#import "GfitMainMenuGridDataSource.h"
#import "GfitScanningTapGestureRecognizer.h"
#import "GfitSearchTapGestureRecognizer.h"
#import "GfitScanTapGestureRecognizer.h"
#import "GfitSearchViewController.h"
#import "GfitScanButtonView.h"
#import "GfitScanButton.h"
#import "GfitSearchButtonView.h"
#import "GfitScanDraggableView.h"
#import "GfitSerialOperationQueue.h"
#import "gfitapp-Constants.h"

const CGFloat kGfitVelocityThreshold = 1000.0f;
const CGFloat kGfitGestureThreshold = 0.33f;
const CGFloat kGfitPanThreshold = 120;

@interface GfitMainMenuViewController () <GfitMenuGridControllerDelegate>

@property GfitHueViewController *hueViewController;
@property GfitMenuGridController *menuGridController;
@property GfitMainMenuGridDataSource *mainMenuGridDataSource;
@property GfitCameraViewController *cameraViewController;

//@property GfitMainMenuDynamicAnimator *mainMenuDynamicAnimator;

//@property (nonatomic, strong) GfitSearchPanGestureRecognizer *searchGestureRecognizer;
//@property (nonatomic, strong) GfitScanPanGestureRecognizer *scanGestureRecognizer;
//@property (nonatomic, strong) GfitScanningPanGestureRecognizer *scanningPanGestureRecognizer;
//@property (nonatomic, strong) GfitScanningTapGestureRecognizer *scanningTapGestureRecognizer;
@property GfitSearchTapGestureRecognizer *searchTapGestureRecognizer;
@property GfitScanTapGestureRecognizer *scanTapGestureRecognizer;
//@property GfitMainMenuSearchDynamicTransition *searchDynamicTransition;
@property GfitMainMenuSearchInteractiveTransition *searchInteractiveTransition;
@property GfitSerialOperationQueue *operationQueue;

@end

@implementation GfitMainMenuViewController

#pragma mark - View Setup Methods

- (void)loadView {
    DLogFunctionLine();
	self.view = [[GfitMainMenuView alloc] initWithFrame:CGRectZero];
}

- (CGSize)preferredContentSize {
	return self.view.bounds.size;
}

#if JUST_THE_ANIMATED_BACKGROUND
- (BOOL)prefersStatusBarHidden {
    return YES;
}
#endif

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate {
	return NO;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods {
    return NO;
}

- (NSString *)title {
	return [[NSBundle mainBundle] localizedStringForKey:@"Main Menu" value:nil table:@"LocalizableStartup"];
}

#pragma mark - View Controller Setup Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // color changing background
    self.hueViewController = [[GfitHueViewController alloc] initWithNibName:nil bundle:nil];
    self.view.hueViewController = self.hueViewController;
    [self.view.scanDraggableView addSubview:self.hueViewController.view];
    [self addChildViewController:self.hueViewController];
    [self.hueViewController didMoveToParentViewController:self];
#if !JUST_THE_ANIMATED_BACKGROUND
    // grid of icon buttons
    self.mainMenuGridDataSource = [[GfitMainMenuGridDataSource alloc] init];
    self.menuGridController = [[GfitMenuGridController alloc] initWithDataSource:self.mainMenuGridDataSource];
    self.menuGridController.delegate = self;
    self.view.menuGridController = self.menuGridController;
    [self.view.searchDraggableView addSubview:self.menuGridController.view];
    [self addChildViewController:self.menuGridController];
    [self.menuGridController didMoveToParentViewController:self];
#endif
    // camera view
    self.cameraViewController = [[GfitCameraViewController alloc] initWithNibName:nil bundle:nil];
    self.cameraViewController.loadsAsync = YES;
    self.view.cameraViewController = self.cameraViewController;
    [self.view addSubview:self.cameraViewController.view];
    [self addChildViewController:self.cameraViewController];
    [self.cameraViewController didMoveToParentViewController:self];
}




//- (void)willMoveToParentViewController:(UIViewController *)parent {
//    [super willMoveToParentViewController:parent];
//
//    DLogFunctionLine();
//
//    if (parent == nil) {
//        self.hueViewController.paused = YES;
//    } else {
//        self.hueViewController.paused = YES;
//    }
//}
//
//- (void)didMoveToParentViewController:(UIViewController *)parent {
//    [super didMoveToParentViewController:parent];
//
//    if (parent == nil) {
//        self.hueViewController.paused = YES;
//    } else {
//        self.hueViewController.paused = NO;
//    }
//}

//- (void)didMoveToParentViewController:(UIViewController *)parent {
//    [super didMoveToParentViewController:parent];
//
//    if (parent == nil) {
//        [self.hueViewController willMoveToParentViewController:nil];
//        [self.hueViewController.view removeFromSuperview];
//        self.view.hueViewController = nil;
//        [self.hueViewController removeFromParentViewController];
//
//        [self.menuGridController willMoveToParentViewController:nil];
//        [self.menuGridController.view removeFromSuperview];
//        self.view.menuGridController = nil;
//        [self.menuGridController removeFromParentViewController];
//
//        [self.cameraViewController willMoveToParentViewController:nil];
//        [self.cameraViewController.view removeFromSuperview];
//        self.view.cameraViewController = nil;
//        [self.cameraViewController removeFromParentViewController];
//    }
//}

static const BOOL firstLaunch = NO;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.operationQueue = [GfitSerialOperationQueue new];

    //self.mainMenuDynamicAnimator = [[GfitMainMenuDynamicAnimator alloc] initWithParent:self];

    self.menuGridController.delegate = self;
    self.mainMenuGridDataSource = [[GfitMainMenuGridDataSource alloc] init];
    self.menuGridController.dataSource = self.mainMenuGridDataSource;

    self.hueViewController.paused = NO;

    //[self setupSearchGestureRecognizer];
    [self setupSearchTapGestureRecognizer];
    //[self setupScanGestureRecognizer];
    [self setupScanTapGestureRecognizer];

    self.searchInteractiveTransition = [[GfitMainMenuSearchInteractiveTransition alloc] initWithParentViewController:self];

}

- (void)viewWillDisappear:(BOOL)animated {
    //    @autoreleasepool {
        DLogFunctionLine();


    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;

    self.mainMenuGridDataSource = nil;
    self.menuGridController.delegate = nil;
    self.menuGridController.dataSource = nil;

    //self.searchDynamicTransition = nil;

    //[self.view viewWillStartAnimating];

        self.hueViewController.paused = YES;
#ifdef DANIM
        [self.mainMenuDynamicAnimator teardownDynamicAnimator];
        self.mainMenuDynamicAnimator = nil;
#endif

    //self.searchInteractiveTransition = nil;

        [self teardownAllGestureRecognizers];

//        [self.view.hueViewController.view removeFromSuperview];
//        self.view.hueViewController = nil;
//        [self.hueViewController willMoveToParentViewController:nil];
//        [self.hueViewController removeFromParentViewController];
//        self.hueViewController = nil;
//
//        [self.view.menuGridController.view removeFromSuperview];
//        self.view.searchDraggableView.menuGridController = nil;
//        [self.menuGridController willMoveToParentViewController:nil];
//        [self.menuGridController removeFromParentViewController];
//        self.menuGridController = nil;
//
//        [self.view.cameraViewController.view removeFromSuperview];
//        self.view.cameraViewController = nil;
//        [self.cameraViewController willMoveToParentViewController:nil];
//        [self.cameraViewController removeFromParentViewController];
//        self.cameraViewController = nil;
//}

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    //self.searchInteractiveTransition = nil;
}

//- (void)viewControllerDidAppearOnscreen {
//    [self.view viewDidStopAnimating];
//}
//
//- (void)viewControllerWillDisappearOffscreen {
//    [self.view viewWillStartAnimating];
//}

//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//    [self.view viewDidStopAnimating];
//}

#pragma mark - Gesture recognizer setup

//- (void)setupSearchGestureRecognizer {
//	self.searchGestureRecognizer = [[GfitSearchPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSearchGesture:)];
//	[self.view addGestureRecognizer:self.searchGestureRecognizer];
//}

- (void)setupSearchTapGestureRecognizer {
    self.searchTapGestureRecognizer = [[GfitSearchTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSearchTapGesture:)];
    [self.view.searchDraggableView.searchButtonView addGestureRecognizer:self.searchTapGestureRecognizer];
}

//- (void)setupScanGestureRecognizer {
//	self.scanGestureRecognizer = [[GfitScanPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScanGesture:)];
//	[self.view addGestureRecognizer:self.scanGestureRecognizer];
//}

- (void)setupScanTapGestureRecognizer {
    self.scanTapGestureRecognizer = [[GfitScanTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScanTapGesture:)];
    [self.view.searchDraggableView.scanButtonView addGestureRecognizer:self.scanTapGestureRecognizer];
}
//
//- (void)setupScanningPanGestureRecognizer {
//	self.scanningPanGestureRecognizer = [[GfitScanningPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScanningPanGesture:)];
//	[self.view addGestureRecognizer:self.scanningPanGestureRecognizer];
//}

//- (void)setupScanningTapGestureRecognizer {
//	self.scanningTapGestureRecognizer = [[GfitScanningTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScanningTapGesture:)];
//	[self.view.scanDraggableViewSnapshot addGestureRecognizer:self.scanningTapGestureRecognizer];
//}
//
//- (void)teardownSearchGestureRecognizer {
//	[self.view removeGestureRecognizer:self.searchGestureRecognizer];
//	self.searchGestureRecognizer = nil;
//}

- (void)teardownSearchTapGestureRecognizer {
    [self.view removeGestureRecognizer:self.searchTapGestureRecognizer];
    self.searchTapGestureRecognizer = nil;
}

//- (void)teardownScanGestureRecognizer {
//	[self.view removeGestureRecognizer:self.scanGestureRecognizer];
//	self.scanGestureRecognizer = nil;
//}

- (void)teardownScanTapGestureRecognizer {
    [self.view removeGestureRecognizer:self.scanTapGestureRecognizer];
    self.scanTapGestureRecognizer = nil;
}

//- (void)teardownScanningPanGestureRecognizer {
//	[self.view removeGestureRecognizer:self.scanningPanGestureRecognizer];
//	self.scanningPanGestureRecognizer = nil;
//}
//
//- (void)teardownScanningTapGestureRecognizer {
//	[self.view removeGestureRecognizer:self.scanningTapGestureRecognizer];
//	self.scanningTapGestureRecognizer = nil;
//}

- (void)teardownAllGestureRecognizers {
    //[self teardownSearchGestureRecognizer];
    [self teardownSearchTapGestureRecognizer];
    //[self teardownScanGestureRecognizer];
    [self teardownScanTapGestureRecognizer];
    //[self teardownScanningPanGestureRecognizer];
    //[self teardownScanningTapGestureRecognizer];
}

#pragma mark - View Appear Event



//- (void)viewDidDisappear:(BOOL)animated {
//	[super viewDidDisappear:animated];
//
//
////	[self.searchTableViewController willMoveToParentViewController:nil];
////	[self.searchTableViewController removeFromParentViewController];
////	self.searchTableViewController = nil;
//}



#pragma mark - View controller user button event Methods


- (void)handleSearchTapGesture:(GfitSearchTapGestureRecognizer *)gc {
    gc.enabled = NO;
    [self search:nil];
}

- (void)_search:(id)sender {
    //if (self.navigationController.viewControllers.count == 1) {
    GfitSearchViewController *searchController = [[GfitSearchViewController alloc] initWithNibName:nil bundle:nil];
    //self.navigationController.delegate = self.searchInteractiveTransition;
    //        searchController.transitioningDelegate = self;
    //        searchController.modalPresentationStyle = UIModalPresentationCustom;
    //        [self presentViewController:searchController animated:YES completion:^{
    //searchController.delegate = self;
    //
    //        }];

    [self.navigationController pushViewController:searchController animated:YES];
}

/**
 *  Required after a search transition animation
 *
 *  @param sender Object sending message
 */
- (void)search:(id)sender {
	//[self _showSearch:YES];

    DLogFunctionLine();
    //[self _search:nil];


    GfitMainMenuViewController * __weak weakSelf = self;
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    NSBlockOperation * __weak weakOperation = operation;
    [operation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            GfitMainMenuViewController *strongSelf = weakSelf;

            if ([[strongSelf.navigationController viewControllers] count] > 1) {
                return;
            }
            if ([weakOperation isCancelled]) {
                return;
            }

            //[weakSelf performSelector:@selector(_search:) withObject:nil afterDelay:0.1];
            GfitSearchViewController *searchController = [[GfitSearchViewController alloc] initWithNibName:nil bundle:nil];
            //strongSelf.navigationController.delegate = strongSelf.searchInteractiveTransition;
            searchController.delegate = strongSelf;
            [strongSelf.navigationController pushViewController:searchController animated:YES];
            //if (strongSelf.searchInteractiveTransition.interactive) {
            //    [searchController searchFieldBecomeFirstResponder];
            //}
        });
    }];
    [self.operationQueue addOperation:operation];
}

// this is a sent message, not part of op queue
//- (void)searchCancel:(id)sender {
//    DLogFunctionLine();
//
//    GfitMainMenuViewController * __weak weakSelf = self;
//    //[self.operationQueue addOperationWithBlock:^{
//    // dispatch_async(dispatch_get_main_queue(), ^{
//            //[self _showSearch:YES];
//
//            //if (self.navigationController.viewControllers.count == 1) {
//            //GfitSearchViewController *searchController = [[GfitSearchViewController alloc] initWithNibName:nil bundle:nil];
//            weakSelf.navigationController.delegate = weakSelf.searchInteractiveTransition;
//            //        searchController.transitioningDelegate = self;
//            //        searchController.modalPresentationStyle = UIModalPresentationCustom;
//            //        [self presentViewController:searchController animated:YES completion:^{
//            //searchController.delegate = self;
//            //
//            //        }];
//
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//            
//            //  });
//        
//    //}];
//}

//- (void)searchCancel:(id)sender {
//	//[self _showSearch:NO];
//}
//
//
///**
// *  Required to transition to search
// *
// *  @param show YES to animate to search from current layout
// */
- (void)_showSearch:(BOOL)show {
	@autoreleasepool {
        DLogFunctionLine();
        [self teardownAllGestureRecognizers];

#ifdef DANIM
        [self.mainMenuDynamicAnimator teardownDynamicAnimator];
#endif
        [self.view viewWillStartAnimating];

		GfitMainMenuViewController *__weak weakSelf = self;
		dispatch_async(dispatch_get_main_queue(), ^{
            GfitMainMenuViewTransition search = ( show ? GfitMainMenuViewSearchTransition : GfitMainMenuViewSearchCancelTransition );
		    [weakSelf.view show:search animated:YES completion:[NSBlockOperation blockOperationWithBlock:^{
                //GfitMainMenuViewController *strongSelf = weakSelf;

                //[weakSelf teardownAllGestureRecognizers];

                if (show) {
                    //DLogFunctionLine();
                } else {
                    DLogFunctionLine();
                    [UIView animateWithDuration:0.1 animations:nil completion:^(BOOL finished){
                        GfitMainMenuViewController *strongSelf = weakSelf;
                        if (finished) {
                            //[strongSelf setupSearchGestureRecognizer];
                            //[strongSelf setupScanGestureRecognizer];
                            [strongSelf.view viewDidStopAnimating];
                        }
                    }];
                }
            }]];
		});
	}
}

/**
 *  Button press requires a push since no velocity was generated by user
 *
 *  @param sender Object sending message
 */
- (void)scan:(id)sender {

//	[self _showScan:YES];
//
//    [self.mainMenuDynamicAnimator setupScanGestureDidFinishWithPush:GfitMainMenuDynamicAnimatorDirectionUp];

    //self.view.searchDraggableView.scanButtonView.scanButton.highlighted = YES;
}

- (void)scanCancel:(id)sender {
	[self _showScan:NO];

#ifdef DANIM
    [self.mainMenuDynamicAnimator setupScanGestureDidFinishWithPush:GfitMainMenuDynamicAnimatorDirectionDown];
#endif
}

/**
 *  Required to transition to scan
 *
 *  @param show YES to animate to scan from current layout
 */
- (void)_showScan:(BOOL)show {
    @autoreleasepool {

        [self teardownAllGestureRecognizers];

        GfitMainMenuViewController * __weak weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [weakSelf.view scanViewWillAppearOnscreen];
        });

        [self.view viewWillStartAnimating];
        [self.view setupDraggableViewSnapshotsIfNotSetup];

#ifdef DANIM
        [self.mainMenuDynamicAnimator teardownDynamicAnimator];
        [self.mainMenuDynamicAnimator setupScanGesture];
#endif

        if (show) {
            //[self teardownScanGestureRecognizer];
            //[self setupScanningPanGestureRecognizer];
            //[strongSelf setupScanningTapGestureRecognizer];
        } else {
            //[self teardownScanningPanGestureRecognizer];
            //[strongSelf setupSearchGestureRecognizer];
            //[self setupScanGestureRecognizer];
        }
#ifdef DANIM
        [self.mainMenuDynamicAnimator setupScanGestureDidFinishTransition:show completion:[NSBlockOperation blockOperationWithBlock:^{
            GfitMainMenuViewController *strongSelf = weakSelf;

            if (show) {
                //[self teardownScanGestureRecognizer];
                //[strongSelf setupScanningPanGestureRecognizer];
                //[strongSelf setupScanningTapGestureRecognizer];
            } else {
                //[self teardownScanningPanGestureRecognizer];
                //[strongSelf setupSearchGestureRecognizer];
                //[strongSelf setupScanGestureRecognizer];
            }

            if (show) {



                // TODO: refresh the view so it isn't still button pressed
                [strongSelf.view teardownDraggableViewSnapshots];

            } else {

                [strongSelf.view viewDidStopAnimating];
                [strongSelf.view teardownDraggableViewSnapshots];
                GfitMainMenuViewController * __weak weakSelf = self;
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    [weakSelf.view scanViewDidDisappearOffscreen];
                });
            }

            GfitMainMenuViewTransition scan = ( show ? GfitMainMenuViewScanTransition : GfitMainMenuViewScanCancelTransition );

            [strongSelf.view show:scan animated:NO completion:[NSBlockOperation blockOperationWithBlock:^{
                [weakSelf.cameraViewController cameraViewDidAppearOnscreen];
            }]];

            [strongSelf.mainMenuDynamicAnimator teardownDynamicAnimator];

//            [UIView animateWithDuration:0.1 animations:nil completion:^(BOOL finished) {
//                GfitMainMenuViewController *strongSelf = weakSelf;
//
//
//
//            }];

        }]];
#endif
    }
}

#pragma mark - Gesture recognizer action methods
#ifdef DANIM
- (void)handleSearchGesture:(GfitSearchPanGestureRecognizer *)gc {
	CGPoint location = [gc locationInView:gc.view];
	location.x = CGRectGetMidX(self.view.bounds);

	switch (gc.state) {
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStatePossible: {

			//[self.mainMenuDynamicAnimator teardownDynamicAnimator];

			break;
		}

		case UIGestureRecognizerStateBegan: {

            [self.mainMenuDynamicAnimator teardownDynamicAnimator];
            [self.view viewWillStartAnimating];
			//[self teardownScanGestureRecognizer];

            [self.mainMenuDynamicAnimator setupSearchGesture];
            [self.mainMenuDynamicAnimator setupSearchGestureAttachmentToLocation:location];

			break;
		}

		case UIGestureRecognizerStateChanged: {

			[self.mainMenuDynamicAnimator updateGestureAttachmentToLocation:location];

			break;
		}

		case UIGestureRecognizerStateRecognized:
		case UIGestureRecognizerStateCancelled: {

            BOOL recognized = (gc.state == UIGestureRecognizerStateRecognized);

            [self.mainMenuDynamicAnimator detachGestureAttachment];

			if (recognized) {
				//[self _showSearch:YES];
			} else {
				//[self _showSearch:NO];
			}

			break;
		}
	}
}


- (void)handleScanGesture:(GfitScanPanGestureRecognizer *)gc {
	CGPoint location = [gc locationInView:gc.view];
	location.x = CGRectGetMidX(self.view.bounds);

	switch (gc.state) {
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStatePossible: {

			//[self.mainMenuDynamicAnimator teardownDynamicAnimator];

			break;
		}
		case UIGestureRecognizerStateBegan: {

            [self.mainMenuDynamicAnimator teardownDynamicAnimator];

            //[self teardownSearchGestureRecognizer];
            //[self teardownScanningPanGestureRecognizer];
            //[self teardownScanningTapGestureRecognizer];

            //[self.view viewWillStartAnimating];
            [self.view setupDraggableViewSnapshotsIfNotSetup];

            GfitMainMenuViewController * __weak weakSelf = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                [weakSelf.view scanViewWillAppearOnscreen];
            });

			[self.mainMenuDynamicAnimator setupScanGesture];
            [self.mainMenuDynamicAnimator setupScanGestureAttachmentToLocation:location];

			break;
		}
		case UIGestureRecognizerStateChanged: {

			[self.mainMenuDynamicAnimator updateGestureAttachmentToLocation:location];

			break;
		}
		case UIGestureRecognizerStateRecognized:
		case UIGestureRecognizerStateCancelled: {

			BOOL recognized = (gc.state == UIGestureRecognizerStateRecognized);
            CGPoint velocity = [gc velocityInView:gc.view];

            [self.mainMenuDynamicAnimator detachGestureAttachment];

			// we're still animating so we want only scanning gestures
            if (recognized) {
                [self _showScan:YES];
            } else {
                [self _showScan:NO];
            }

            [self.mainMenuDynamicAnimator setupScanGestureDidFinishWithVelocity:velocity];

			break;
		}
	}
}
#endif
- (void)handleScanTapGesture:(GfitScanTapGestureRecognizer *)gc {
    switch (gc.state) {
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateBegan:
            self.view.searchDraggableView.scanButtonView.scanButton.highlighted = YES;
            break;
        case UIGestureRecognizerStateCancelled:
            self.view.searchDraggableView.scanButtonView.scanButton.highlighted = NO;
            break;
        case UIGestureRecognizerStateEnded:
            [self scan:nil];
            self.view.searchDraggableView.scanButtonView.scanButton.highlighted = NO;
            break;

    }
}

#ifdef DANIM
- (void)handleScanningPanGesture:(GfitScanningPanGestureRecognizer *)gc {
	CGPoint location = [gc locationInView:gc.view];
	location.x = CGRectGetMidX(self.view.bounds);

	switch (gc.state) {
		case UIGestureRecognizerStateFailed:
		case UIGestureRecognizerStatePossible: {

			[self.mainMenuDynamicAnimator teardownDynamicAnimator];

			break;
		}
		case UIGestureRecognizerStateBegan: {

            [self.mainMenuDynamicAnimator teardownDynamicAnimator];

            //[self teardownScanGestureRecognizer];
            //[self teardownScanningTapGestureRecognizer];
            //[self teardownSearchGestureRecognizer];

            [self.view viewWillStartAnimating];
            [self.view setupDraggableViewSnapshotsIfNotSetup];

			[self.mainMenuDynamicAnimator setupScanGesture];
            [self.mainMenuDynamicAnimator setupScanGestureAttachmentToLocation:location];
			break;
		}
		case UIGestureRecognizerStateChanged: {

			[self.mainMenuDynamicAnimator updateGestureAttachmentToLocation:location];

			break;
		}
		case UIGestureRecognizerStateRecognized:
		case UIGestureRecognizerStateCancelled: {

			BOOL recognized = (gc.state == UIGestureRecognizerStateRecognized);
            CGPoint velocity = [gc velocityInView:gc.view];

            [self.mainMenuDynamicAnimator detachGestureAttachment];

			// we're still animating so only scanning gestures

            if (recognized) {
                [self _showScan:NO];
            } else {
                [self _showScan:YES];
            }

            [self.mainMenuDynamicAnimator setupScanGestureDidFinishWithVelocity:velocity];

			break;
		}
	}
}
#endif
- (void)handleScanningTapGesture:(UITapGestureRecognizer *)gc {

	[self scanCancel:nil];
}

#pragma mark - Menu grid controller delegate

- (void)gridControllerDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    GfitMainMenuViewController * __weak weakSelf = self;
    [self.operationQueue addOperationWithBlock:^{
        GfitMainMenuViewController *strongSelf = weakSelf;

        UIViewController *viewController = [strongSelf.mainMenuGridDataSource mainMenuGridDidSelectItemAtIndexPath:indexPath];


        [strongSelf.horizontalSlidingDelegate pushToViewController:viewController];

    }];
//	@autoreleasepool {
//
//		Class controllerClass = [self.mainMenuGridDataSource mainMenuGridDidSelectItemAtIndexPath:indexPath];
//        
//        GfitRootNavigationEvent *event = [[GfitRootNavigationEvent alloc] init];
//        event.rootNavigationEventClass = controllerClass;
//        BOOL handled = [[UIApplication sharedApplication] sendAction:event.eventSelector to:nil from:self forEvent:event];
//
//        NSAssert(handled, @"gridControllerDidSelectItemAtIndexPath:%@ handled:%i", indexPath, handled);
//	}
}

//#pragma mark - UIViewController animated transitioning
//
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
//    return 5.0;
//    return kGfitTransitionFastTime;
//}
//
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    @autoreleasepool {
//
//        DLogObject(transitionContext);
//
//        //GfitMainMenuViewController * __weak weakSelf = self;
//        UIView *containerView = [transitionContext containerView];
//        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        UIView *backgroundView = [[UIView alloc] initWithFrame:containerView.bounds];
//        backgroundView.backgroundColor = [UIColor whiteColor];
//        [containerView addSubview:backgroundView];
//
//        BOOL draggableViewFromAlpha, draggableViewToAlpha;
//
//        UIView *hueViewControllerSnapshotView;
//        UIView *draggableSnapshotView;
//        UIImage *searchBackgroundImage = self.view.searchDraggableView.searchBackgroundImageView.image;
//        UIImageView *searchBackgroundImageView = [[UIImageView alloc] initWithImage:searchBackgroundImage];
//
//        hueViewControllerSnapshotView = [self.hueViewController.view snapshotViewAfterScreenUpdates:YES];
//        self.view.searchDraggableView.searchButtonView.hidden = YES;
//        draggableSnapshotView = [self.view.searchDraggableView snapshotViewAfterScreenUpdates:YES];
//        GfitSearchButtonView *searchButtonView = [[GfitSearchButtonView alloc] initWithFrame:CGRectZero];
//        searchButtonView.userInteractionEnabled = NO;
//        const CGFloat searchButtonTopMargin = searchButtonView.topLayoutGuide.length;
//        const CGSize searchButtonViewSize = searchButtonView.intrinsicContentSize;
//        searchButtonView.frame = CGRectMake(0, searchButtonTopMargin, CGRectGetWidth(containerView.bounds), searchButtonViewSize.height);
//        self.view.searchDraggableView.searchButtonView.hidden = NO;
//
//        [containerView addSubview:hueViewControllerSnapshotView]; // main menu
//        [containerView addSubview:searchBackgroundImageView];
//        [containerView addSubview:draggableSnapshotView];
//        [containerView addSubview:searchButtonView];
//
//        if (self.presentedViewController.isBeingPresented) {
//            //UIView *mainMenuSnapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//            //UIView *searchSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:NO];
//                                                    //[containerView addSubview:toVC.view]; // search
//
//
//            draggableViewFromAlpha = 1;
//            draggableViewToAlpha = 0;
//        } else {
//            //[containerView addSubview:toVC.view]; // main menu
//            //[containerView addSubview:fromVC.view]; // search
//
//            draggableViewFromAlpha = 0;
//            draggableViewToAlpha = 1;
//        }
//
//
//        draggableSnapshotView.alpha = draggableViewFromAlpha;
//        searchBackgroundImageView.alpha = draggableViewToAlpha;
//
////        [fromVC willMoveToParentViewController:nil];
//
//        [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                              delay:0.0f
//                            options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
////
////                             // transition the misc main menu elements out when searching
////                             [UIView animateWithDuration:kGfitTransitionFastTime delay:(strongSelf.searching ? 0 : kGfitTransitionDelay) options:UIViewAnimationOptionCurveEaseInOut animations:^{
////GfitMainMenuViewController *strongSelf = weakSelf;
//
//                             draggableSnapshotView.alpha = draggableViewToAlpha;
//                             searchBackgroundImageView.alpha = draggableViewFromAlpha;
//
//                             //strongSelf.searchDraggableView.scanButtonView.alpha = !strongSelf.searching;
//                             // strongSelf.searchDraggableView.menuGridController.view.alpha = !strongSelf.searching;
//
//
//                         } completion:^(BOOL finished) {
//                             if (finished) {
//
//                                 NSArray *subviews = containerView.subviews;
//                                 for (UIView *view in subviews) {
//                                     [view removeFromSuperview];
//                                 }
//
////                                 [hueViewControllerSnapshotView removeFromSuperview];
////                                 [searchBackgroundImageView removeFromSuperview];
////                                 [draggableSnapshotView removeFromSuperview];
////                                 [searchButtonView removeFromSuperview];
////
////                                 [fromVC.view removeFromSuperview];
////                                 [fromVC removeFromParentViewController];
//
//                                 
//
//                                 //[containerView addSubview:fromVC.view];
//                                 //[containerView addSubview:toVC.view];
//
//                                 //[self addChildViewController:toVC];
//                                 //[containerView addSubview:toVC.view];
//
//
//                                 draggableSnapshotView.alpha = draggableViewToAlpha;
//                                 searchBackgroundImageView.alpha = draggableViewFromAlpha;
//
//                                 //strongSelf.searchDraggableView.scanButtonView.alpha = !strongSelf.searching;
//                                 //strongSelf.searchDraggableView.menuGridController.view.alpha = !strongSelf.searching;
//
//                                 if ([transitionContext transitionWasCancelled]) {
//
//                                 } else {
//
//                                 }
//
//                                 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                             }
//                         }];
//    }
//}
//
//
//


@end
