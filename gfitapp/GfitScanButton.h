//
//  GfitScanButton.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/4/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GfitScanButton : UIButton

@property (nonatomic, strong) UIView *blankingView;

/**
 *  Required for initialization
 */
- (void)g_setup;

@end
