//
//  GfitHealthView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/1/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitHealthView.h"
#import "GfitMenuGridController.h"

@implementation GfitHealthView

/**
 *  Required after setting self.menuGridController to finish setup
 */
- (void)didSetMenuGridController {
    @autoreleasepool {
        [self addSubview:self.menuGridController.view];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    @autoreleasepool {
        const CGFloat height = CGRectGetHeight(self.bounds);

        const CGSize gridSize = self.menuGridController.preferredContentSize;
        self.menuGridController.view.frame = CGRectMake(0, height - gridSize.height - self.menuGridController.bottomLayoutGuide.length, gridSize.width, gridSize.height);
    }
}

@end
