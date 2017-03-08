//
//  GHealthView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/8/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GHealthView.h"
#import "GMenuGridController.h"

@interface GHealthView ()

@property (nonatomic, weak) GMenuGridController *gridController;

@end

@implementation GHealthView

#pragma mark - View Setup Methods

- (instancetype)initWithGridController:(GMenuGridController*)gridController {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];
        self.gridController = gridController;

        [self addSubview:self.gridController.view];
    }
    return self;
}

#pragma mark - View Layout Methods

- (void)setNeedsLayout {
    [super setNeedsLayout];

    [self.gridController.collectionViewLayout invalidateLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect bounds = self.bounds;
    //CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);

    CGSize gridSize = self.gridController.preferredContentSize;
    self.gridController.view.frame = CGRectMake(0, height - gridSize.height - self.gridController.bottomLayoutGuide.length, gridSize.width, gridSize.height);
    DLogCGRect(self.gridController.view.frame);

    [self bringSubviewToFront:self.gridController.view];
}

@end
