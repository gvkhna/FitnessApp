//
//  GfitMainMenuDynamicAnimatorProtocol.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/17/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GfitSearchDraggableView.h"

@protocol GfitMainMenuDynamicAnimatorViewsProtocol <NSObject>
@required

- (GfitSearchDraggableView*)searchDraggableView;
- (UIView*)scanDraggableViewSnapshot;
- (UIImageView*)scanStatusBarBackgroundImageView;

@end

@protocol GfitMainMenuDynamicAnimatorProtocol <NSObject>
@required

- (UIView<GfitMainMenuDynamicAnimatorViewsProtocol> *)view;

@end
