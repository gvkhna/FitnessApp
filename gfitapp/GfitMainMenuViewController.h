//
//  GfitMainMenuViewController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitHorizontalSlidingTabBarDelegateProtocol.h"
#import "GfitMainMenuDynamicAnimatorProtocol.h"
#import "GfitMainMenuView.h"
#import "GfitMainMenuSearchInteractiveTransition.h"


extern const CGFloat kGfitVelocityThreshold;
extern const CGFloat kGfitGestureThreshold;
extern const CGFloat kGfitPanThreshold;

/**
 *  `GfitMainMenuViewController` encapsulates the entire launch functionality up till viewDidAppear:
 *
 *   Upon finishing launch the view controller is responsible for setting up scan, search table, and
 *   the root `UINavigationController` for arbitrary `UIViewController` objects to be pushed
 */
@interface GfitMainMenuViewController : UIViewController <GfitMainMenuDynamicAnimatorProtocol,UIViewControllerTransitioningDelegate, GfitMainMenuSearchInteractiveTransitionProtocol>

@property (nonatomic, weak) id<GfitHorizontalSlidingTabBarDelegateProtocol> horizontalSlidingDelegate;

//- (void)handleSearchGesture:(GfitSearchPanGestureRecognizer *)gc;

@property (nonatomic, strong) GfitMainMenuView *view;

@end
