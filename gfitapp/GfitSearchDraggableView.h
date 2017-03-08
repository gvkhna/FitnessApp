//
//  GfitSearchDraggableView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/6/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitMainMenuSearchInteractiveTransition.h"

@class GfitSearchButtonView, GfitScanButtonView;

@interface GfitSearchDraggableView : UIView <GfitMainMenuSearchInteractiveTransitionSearchDraggableViewProtocol>

@property (nonatomic, readonly) GfitSearchButtonView *searchButtonView;
@property (nonatomic, readonly) GfitScanButtonView *scanButtonView;

@end
