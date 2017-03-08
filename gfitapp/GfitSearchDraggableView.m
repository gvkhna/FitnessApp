//
//  GfitSearchDraggableView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/6/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchDraggableView.h"
#import "GfitSearchButtonView.h"
#import "GfitScanButtonView.h"
#import "GfitMenuGridController.h"


@interface GfitSearchDraggableView ()

@property (nonatomic, strong) GfitSearchButtonView *searchButtonView;
@property (nonatomic, strong) GfitScanButtonView *scanButtonView;

@end

@implementation GfitSearchDraggableView

#pragma mark - View setup methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // create search field
        _searchButtonView = [[GfitSearchButtonView alloc] initWithFrame:CGRectZero];
        _searchButtonView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_searchButtonView];

        // create scan button
        _scanButtonView = [[GfitScanButtonView alloc] initWithFrame:CGRectZero];
        _scanButtonView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_scanButtonView];
    }
    return self;
}

#pragma mark - View Layout Methods

- (void)layoutSubviews {
    @autoreleasepool {
        [super layoutSubviews];

        const CGRect bounds = self.bounds;
        const CGFloat width = CGRectGetWidth(bounds);
        const CGFloat height = CGRectGetHeight(bounds);

        const CGFloat searchButtonTopMargin = self.searchButtonView.topLayoutGuide.length;
        const CGSize searchButtonViewSize = self.searchButtonView.intrinsicContentSize;
        self.searchButtonView.frame = CGRectMake(0, searchButtonTopMargin, width, searchButtonViewSize.height);

        const CGFloat scanButtonTopMargin = self.scanButtonView.topLayoutGuide.length;
        const CGSize scanButtonViewSize = self.scanButtonView.intrinsicContentSize;
        self.scanButtonView.frame = CGRectMake(0, scanButtonTopMargin, width, scanButtonViewSize.height);

    }
}

@end
