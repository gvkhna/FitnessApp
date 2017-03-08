//
//  GfitSearchView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitSearchViewController.h"
#import "GfitSearchTextFieldView.h"
#import "GfitSearchTableViewController.h"

@class GfitSearchTableViewController;

@interface GfitSearchView : UIView <GfitSearchViewControllerViewProtocol>

@property (nonatomic, weak) GfitSearchTableViewController *searchTableViewController;
@property (nonatomic, strong) UIImageView *searchViewBackgroundImageView;
@property (nonatomic, strong) GfitSearchTextFieldView *searchTextFieldView;

- (void)didSetSearchTableViewController;

@end
