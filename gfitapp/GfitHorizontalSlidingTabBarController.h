//
//  GfitHorizontalSlidingTabBarController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 2/7/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitHorizontalSlidingTabBarDelegateProtocol.h"

@interface GfitHorizontalSlidingTabBarController : UITabBarController

@property (nonatomic, assign, readwrite) UIStatusBarStyle transitioningStatusBarStyle;
@property (nonatomic, assign, readwrite, getter = isTransitioningStatusBarStyle) BOOL transitionStatusBarStyle;

@end
