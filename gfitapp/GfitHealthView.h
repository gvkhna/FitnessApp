//
//  GfitHealthView.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/1/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GfitMenuGridController;

@interface GfitHealthView : UIView

/**
 *  Required after adding as a child view controller
 */
@property (nonatomic, weak) GfitMenuGridController *menuGridController;

/**
 *  Required after setting self.menuGridController to finish setup
 */
- (void)didSetMenuGridController;

@end
