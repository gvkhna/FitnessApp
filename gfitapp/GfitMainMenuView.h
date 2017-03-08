//
//  GfitMainMenuView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitMainMenuDynamicAnimatorProtocol.h"
#import "GfitMainMenuSearchInteractiveTransition.h"

typedef NS_ENUM(NSInteger, GfitMainMenuViewTransition) {
    GfitMainMenuViewSearchTransition,
    GfitMainMenuViewSearchCancelTransition,
    GfitMainMenuViewScanTransition,
    GfitMainMenuViewScanCancelTransition
};

@class GfitHueViewController;
@class GfitSearchTableViewController;
@class GfitCameraViewController;
@class GfitSearchDraggableView;
@class GfitScanDraggableView;
@class GfitScanStatusBarBackgroundImageView;
@class GfitMenuGridController;

@interface GfitMainMenuView : UIView <GfitMainMenuDynamicAnimatorViewsProtocol, GfitMainMenuSearchInteractiveTransitionViewProtocol>

///**
// *  Returns YES if currently showing search mode
// */
//@property (nonatomic, readonly, assign, getter = isSearching) BOOL searching;

/**
 *  Returns YES if currently showing scan mode
 */
@property (nonatomic, readonly, assign, getter = isScanning) BOOL scanning;

/**
 *  The `UIView` object that allows panning-down-to-search gesture
 */
@property (nonatomic, readonly) GfitSearchDraggableView *searchDraggableView;

///**
// *  The `UIView` object that is dragged for search gesture
// */
//@property (nonatomic, readonly) UIView *searchDraggableViewSnapshot;

/**
 *  The `UIView` object that allows panning-up-to-scan gesture
 */
@property (nonatomic, readonly) GfitScanDraggableView *scanDraggableView;

/**
 *  The `UIView` object that is dragged for scanning gesture
 */
@property (nonatomic, readonly) UIView *scanDraggableViewSnapshot;

//- (void)matchSearchDraggableViewSnapshot;

- (void)setupDraggableViewSnapshotsIfNotSetup;
- (void)setupDraggableViewSnapshots;
- (void)teardownDraggableViewSnapshots;

- (void)viewWillStartAnimating;
- (void)viewDidStopAnimating;

- (void)scanViewWillAppearOnscreen;
- (void)scanViewDidDisappearOffscreen;

/**
 *  The `UIImageView` object that adds a background to the status bar when scanning
 */
@property (nonatomic, readonly) UIImageView *scanStatusBarBackgroundImageView;

/**
 *  Required to set reference after adding as child view controller
 */
@property (nonatomic, weak) GfitHueViewController *hueViewController;
@property (nonatomic, weak) GfitSearchTableViewController *searchTableViewController;
@property (nonatomic, weak) GfitCameraViewController *cameraViewController;
@property (nonatomic, weak) GfitMenuGridController *menuGridController;

- (void)show:(GfitMainMenuViewTransition)transition animated:(BOOL)animated completion:(NSBlockOperation *)completion;


@end
