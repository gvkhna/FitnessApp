//
//  GfitMainMenuView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuView.h"
#import "GfitMainMenuViewController.h"
#import "GfitHueViewController.h"
#import "GfitCameraViewController.h"
#import "GfitSearchTableViewController.h"
#import "GfitSearchButtonView.h"
#import "GfitSearchField.h"
#import "GfitScanButton.h"
#import "GfitScanButtonView.h"
#import "GfitMenuGridController.h"
#import "GfitSearchDraggableView.h"
#import "GfitScanDraggableView.h"
#import "UIView+GAnimateBlock.h"
#import "UIView+GDropShadow.h"
#import "gfitapp-Constants.h"

@interface GfitScanStatusBarBackgroundImageView : UIImageView

@end

@implementation GfitScanStatusBarBackgroundImageView

@end

@interface GfitMainMenuView ()

@property (nonatomic, strong) GfitSearchDraggableView *searchDraggableView;
@property (nonatomic, strong) GfitScanDraggableView *scanDraggableView;
@property (nonatomic, strong) GfitScanStatusBarBackgroundImageView *scanStatusBarBackgroundImageView;
@property (nonatomic, strong) UIView *scanDraggableViewSnapshot;
//@property (nonatomic, strong) UIView *searchDraggableViewSnapshot;
@property (nonatomic, assign, getter = isSearching) BOOL searching;
@property (nonatomic, assign, getter = isScanning) BOOL scanning;

@end

@implementation GfitMainMenuView

#pragma mark - Object Setup Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        @autoreleasepool {

            self.backgroundColor = [UIColor blackColor];
            

            _scanDraggableView = [[GfitScanDraggableView alloc] initWithFrame:frame];
            _scanDraggableView.backgroundColor = [UIColor whiteColor];
            _scanDraggableView.opaque = YES;
            _scanDraggableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_scanDraggableView g_setShadow:YES animated:NO];
            [self addSubview:_scanDraggableView];
#if !JUST_THE_ANIMATED_BACKGROUND

            _searchDraggableView = [[GfitSearchDraggableView alloc] initWithFrame:frame];
            _searchDraggableView.exclusiveTouch = NO; // very important, otherwise touches won't get sent to subviews
            _searchDraggableView.clipsToBounds = NO;
            _searchDraggableView.backgroundColor = [UIColor clearColor];
            _searchDraggableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_scanDraggableView addSubview:_searchDraggableView];
#endif
            UIImage *scanStatusBarImage = [UIImage imageNamed:@"scan_status_bar"];

            NSParameterAssert(scanStatusBarImage != nil);

            _scanStatusBarBackgroundImageView = [[GfitScanStatusBarBackgroundImageView alloc] initWithImage:scanStatusBarImage];
            _scanStatusBarBackgroundImageView.alpha = 0;
            [self addSubview:_scanStatusBarBackgroundImageView];
        }
    }
    return self;
}


#pragma mark - View Layout Methods
//
//- (void)layoutIfNeeded {
//    [super layoutIfNeeded];
//
//    [self.menuGridController.view layoutIfNeeded];
//}

- (void)layoutSubviews {
    @autoreleasepool {
        [super layoutSubviews];

        const CGSize statusBarSize = self.scanStatusBarBackgroundImageView.image.size;
        self.scanStatusBarBackgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), statusBarSize.height);

        const CGSize hueViewControllerSize = self.hueViewController.preferredContentSize;
        const CGFloat hueViewControllerTopMargin = self.hueViewController.topLayoutGuide.length;
        self.hueViewController.view.frame = CGRectMake(0, hueViewControllerTopMargin, hueViewControllerSize.width, hueViewControllerSize.height);
    //
    //    CGSize hueImageSize = self.hueImageView.image.size;
    //    self.hueImageView.frame = CGRectMake(0, 0, hueImageSize.width, hueImageSize.width);
//        if (self.isSearching) {
//            self.searchDraggableView.frame = self.bounds;
////            self.searchDraggableView.contentOffset = CGPointZero;
////            self.searchDraggableView.contentSize = self.bounds.size;
//        } else {
//            //self.searchDraggableView.frame = CGRectOffset(self.bounds, 0, (kGfitPanThreshold));
//            //self.searchDraggableView.contentInset = UIEdgeInsetsMake(kGfitPanThreshold, 0, 0, 0);
////            self.searchDraggableView.contentOffset = CGPointMake(0, (kGfitPanThreshold));
////            self.searchDraggableView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + (kGfitPanThreshold));
//        }
        //self.scanDraggableView.frame = self.bounds;

        //const CGFloat height = CGRectGetHeight(self.bounds);


        //DLogCGRect(self.bounds);


        //self.cameraViewController.view.frame = self.bounds;



//        self.scanDraggableView.bounds = self.bounds;
//        self.scanDraggableView.frame = self.bounds;
//        self.searchDraggableView.bounds = self.bounds;
//        self.searchDraggableView.frame = self.bounds;
        //self.searchDraggableViewSnapshot.frame = self.bounds;
//
//        [self.searchDraggableView setNeedsLayout];
//        [self.searchDraggableView layoutIfNeeded];
//
//        //[self.searchDraggableView layoutIfNeeded];
//
//        [self.menuGridController.view setNeedsLayout];
//        [self.menuGridController.view layoutIfNeeded];


//        const CGFloat gridBottomMargin = self.menuGridController.bottomLayoutGuide.length;
//        const CGSize gridSize = self.menuGridController.preferredContentSize;
//        const CGRect gridFrame = CGRectMake(0, height - gridSize.height - gridBottomMargin, gridSize.width, gridSize.height);
//        self.menuGridController.view.bounds = self.bounds;
//        self.menuGridController.view.frame = gridFrame;
//        DLogCGRect(self.menuGridController.view.frame);

        self.menuGridController.view.frame = [self.menuGridController preferredContentFrame:self.bounds];

        //        DLogCGSize(CGSizeMake(preferredSize.width, preferredSize.height - kGfitMenuGridControllerTopMargin - kGfitMenuGridMargin));
        //        return CGSizeMake(preferredSize.width, preferredSize.height - kGfitMenuGridControllerTopMargin - kGfitMenuGridMargin);

        //DLogCGRect(self.menuGridController.view.bounds);


        CGRect scanFrame = self.bounds;
        scanFrame.origin.y = self.isScanning ? -(CGRectGetHeight(self.bounds) - kGfitPanThreshold) : 0;
        self.scanDraggableView.frame = scanFrame;
        self.scanDraggableViewSnapshot.frame = scanFrame;

        self.cameraViewController.view.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(kGfitPanThreshold, 0, 0, 0));

        //self.searchDraggableView.contentOffset = CGPointMake(0, kPanGestureThreshold);

        //[self bringSubviewToFront:self.scanStatusBarBackgroundImageView];

        //[self bringSubviewToFront:self.hueViewController.view];

        [self.scanDraggableView bringSubviewToFront:self.searchDraggableView];

        [self bringSubviewToFront:self.cameraViewController.view];
        [self bringSubviewToFront:self.scanDraggableView];
        [self bringSubviewToFront:self.scanDraggableViewSnapshot];
        [self bringSubviewToFront:self.scanStatusBarBackgroundImageView];

        //[self.searchDraggableView layoutIfNeeded];
        //[self.scanDraggableView layoutIfNeeded];

//
//        //[self sendSubviewToBack:self.scanDraggableView];
//
//        //[self.scanDraggableView sendSubviewToBack:self.hueViewController.view];
//        [self bringSubviewToFront:self.cameraViewController.view];
//        [self bringSubviewToFront:self.scanDraggableView];
//        [self bringSubviewToFront:self.scanDraggableViewSnapshot];
//        //[self bringSubviewToFront:self.searchTableViewController.view];
//        [self bringSubviewToFront:self.scanStatusBarBackgroundImageView];

    }
}

#pragma mark - View animation event methods

- (void)setupDraggableViewSnapshots {
    @autoreleasepool {
        self.scanDraggableViewSnapshot = [[UIView alloc] initWithFrame:CGRectZero];
        [self.scanDraggableViewSnapshot g_setShadow:YES animated:NO];
        self.scanDraggableViewSnapshot.backgroundColor = [UIColor whiteColor];
        UIView *snapshotView = [self.hueViewController.view snapshotViewAfterScreenUpdates:NO];
        [self.scanDraggableViewSnapshot addSubview:snapshotView];
        //self.searchDraggableView.hidden = YES;
        //self.searchDraggableViewSnapshot = [self.searchDraggableView snapshotViewAfterScreenUpdates:YES];
        UIView *searchDraggableViewSnapshot = [self.searchDraggableView snapshotViewAfterScreenUpdates:NO];
        [self addSubview:self.scanDraggableViewSnapshot];
        [self.scanDraggableViewSnapshot addSubview:searchDraggableViewSnapshot];
        self.searchDraggableView.hidden = YES;
        self.scanDraggableView.hidden = YES;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}
//
//- (void)matchSearchDraggableViewSnapshot {
//    self.searchDraggableView.frame = self.searchDraggableViewSnapshot.frame;
//}

- (void)teardownDraggableViewSnapshots {
    @autoreleasepool {
        [self.scanDraggableViewSnapshot removeFromSuperview];
        self.searchDraggableView.hidden = NO;
        self.scanDraggableView.hidden = NO;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        self.scanDraggableViewSnapshot = nil;
    }
}

- (void)setupDraggableViewSnapshotsIfNotSetup {
    // switch to snapshots
    if (!self.scanDraggableViewSnapshot) {
        [self setupDraggableViewSnapshots];
    }
}

- (void)viewWillStartAnimating {
    GfitMainMenuView * __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.hueViewController.paused = YES;
    });
}

- (void)viewDidStopAnimating {
    GfitMainMenuView * __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.hueViewController.paused = NO;
    });
}


- (void)scanViewWillAppearOnscreen {
    [self.cameraViewController startRunningCaptureSession];
}

- (void)scanViewDidDisappearOffscreen {
    [self.cameraViewController stopRunningCaptureSession];
}


#pragma mark - View animation methods

- (void)show:(GfitMainMenuViewTransition)transition animated:(BOOL)animated completion:(NSBlockOperation *)completion {
    
    GfitMainMenuView * __weak weakSelf = self;
    [UIView g_performAnimations:animated blockOperation:[NSBlockOperation blockOperationWithBlock:^{
        GfitMainMenuView *strongSelf = weakSelf;

        // blankout values
        strongSelf.searching = NO;
        strongSelf.scanning = NO;

        BOOL searchTransition = NO;
        BOOL scanTransition = NO;

        switch (transition) {
            case GfitMainMenuViewSearchTransition:
                strongSelf.searching = YES;
            case GfitMainMenuViewSearchCancelTransition:
                searchTransition = YES;
                break;
            case GfitMainMenuViewScanTransition:
                strongSelf.scanning = YES;
            case GfitMainMenuViewScanCancelTransition:
                scanTransition = YES;
                break;
        }




        [UIView animateWithDuration:kGfitTransitionFastTime delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            GfitMainMenuView *strongSelf = weakSelf;

            [strongSelf setNeedsLayout];
            [strongSelf layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (finished) {
                GfitMainMenuView *strongSelf = weakSelf;
                
                [strongSelf setNeedsLayout];
                [strongSelf layoutIfNeeded];

                [completion start];
            }
        }];





        //GfitSearchField *searchField = strongSelf.searchDraggableView.searchButtonView.searchField;

        // must be after becomeFirstResponder
        //searchField.userInteractionEnabled = NO;

        // the rest is only necessary for a search transition
        if (!searchTransition) {
            return;
        }

        // transition the search background view in when searching
//        [UIView animateWithDuration:kGfitTransitionFadeTime delay:0 options:0 animations:^{
//            GfitMainMenuView *strongSelf = weakSelf;
//
//            strongSelf.searchBackgroundImageView.alpha = strongSelf.searching;
//        } completion:^(BOOL finished){
//            GfitMainMenuView *strongSelf = weakSelf;
//
//            if (finished) {
//                strongSelf.searchBackgroundImageView.alpha = strongSelf.searching;
//            }
//        }];

        
    }]];
}

@end
