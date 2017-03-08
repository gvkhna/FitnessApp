//
//  GfitSearchViewController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GfitSearchViewControllerTextViewProtocol <NSObject>

- (UITextField *)searchField;
- (UIButton *)searchCancelButton;

@end

@protocol GfitSearchViewControllerViewProtocol <NSObject>

- (id<GfitSearchViewControllerTextViewProtocol>)searchTextFieldView;

@end

@protocol GfitSearchViewControllerCancelProtocol <NSObject>

- (void)searchCancel:(id)sender;

@end

@interface GfitSearchViewController : UIViewController

@property (nonatomic, weak) id<UIViewControllerTransitioningDelegate> delegate;

- (void)searchFieldBecomeFirstResponder;

@end
