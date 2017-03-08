//
//  GfitScanButtonView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GfitScanButton;

@interface GfitScanButtonView : UIView

@property (nonatomic, readonly) GfitScanButton *scanButton;

- (id<UILayoutSupport>)topLayoutGuide;

@end
