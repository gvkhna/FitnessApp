//
//  GfitSearchTextFieldView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitSearchViewController.h"

extern const CGFloat kGfitSearchFieldViewTopMargin;
extern const CGFloat kGfitSearchFieldViewInset;

extern const CGFloat kGfitSearchFieldIconInset;
extern const CGFloat kGfitSearchFieldTextInset;

@interface GfitSearchTextFieldView : UIView <UILayoutSupport, GfitSearchViewControllerTextViewProtocol>

- (id<UILayoutSupport>)topLayoutGuide;

@end
