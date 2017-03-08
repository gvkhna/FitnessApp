//
//  GfitSearchButtonView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GfitSearchField;

@interface GfitSearchButtonView : UIView

@property (nonatomic, readonly) GfitSearchField *searchField;

- (id<UILayoutSupport>)topLayoutGuide;

@end
