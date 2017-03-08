//
//  GfitMainMenuSearchInteractiveTransition.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GfitMainMenuSearchInteractiveTransitionSearchDraggableViewProtocol <NSObject>

- (UIView*)searchButtonView;
- (UIView*)scanButtonView;

@end

@protocol GfitMainMenuSearchInteractiveTransitionViewProtocol <NSObject>

- (UIView<GfitMainMenuSearchInteractiveTransitionSearchDraggableViewProtocol>*)searchDraggableView;

@end

@protocol GfitMainMenuSearchInteractiveTransitionProtocol <NSObject>

- (UIView<GfitMainMenuSearchInteractiveTransitionViewProtocol>*)view;
- (UIViewController*)hueViewController;
- (UIViewController*)menuGridController;

@end

@protocol GfitMainMenuSearchInteractiveTransitionSearchTextFieldViewProtocol <NSObject>

- (UIView*)searchCancelButton;

@end

@protocol GfitMainMenuSearchInteractiveTransitionSearchViewProtocol <NSObject>

- (UIImageView*)searchViewBackgroundImageView;
- (UIViewController*)searchTableViewController;
- (UIView<GfitMainMenuSearchInteractiveTransitionSearchTextFieldViewProtocol>*)searchTextFieldView;

@end

@protocol GfitMainMenuSearchInteractiveTransitionSearchProtocol <NSObject>

- (UIView<GfitMainMenuSearchInteractiveTransitionSearchViewProtocol>*)view;

@end

@interface GfitMainMenuSearchInteractiveTransition : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isPresenting) BOOL presenting;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;

- (instancetype)initWithParentViewController:(id<GfitMainMenuSearchInteractiveTransitionProtocol>)viewController;

@end
