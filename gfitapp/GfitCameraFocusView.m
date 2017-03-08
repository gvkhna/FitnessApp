//
//  GfitCameraFocusView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/19/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitCameraFocusView.h"

const CGFloat kGfitCameraFocusViewExtendRange = 0.15;

@interface GfitCameraFocusView ()

@property (nonatomic, strong) UIView *leftBorderView;
@property (nonatomic, strong) UIView *rightBorderView;
@property (nonatomic, strong) UIView *leftTopBorderView;
@property (nonatomic, strong) UIView *rightTopBorderView;
@property (nonatomic, strong) UIView *leftBottomBorderView;
@property (nonatomic, strong) UIView *rightBottomBorderView;
@property (nonatomic, strong) UIColor *currentColor;


@end

@implementation GfitCameraFocusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        //self.contentMode = UIViewContentModeRedraw;

        self.currentColor = [UIColor colorWithRed:0.816 green:0.612 blue:0.180 alpha:1.000];
        UIColor *otherColor = [UIColor colorWithRed:0.996 green:0.816 blue:0.244 alpha:1.000];

        _leftBorderView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftBorderView.backgroundColor = self.currentColor;
        [self addSubview:_leftBorderView];

        _rightBorderView = [[UIView alloc] initWithFrame:CGRectZero];
        _rightBorderView.backgroundColor = self.currentColor;
        [self addSubview:_rightBorderView];

        _leftTopBorderView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftTopBorderView.backgroundColor = self.currentColor;
        [self addSubview:_leftTopBorderView];

        _rightTopBorderView = [[UIView alloc] initWithFrame:CGRectZero];
        _rightTopBorderView.backgroundColor = self.currentColor;
        [self addSubview:_rightTopBorderView];

        _leftBottomBorderView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftBottomBorderView.backgroundColor = self.currentColor;
        [self addSubview:_leftBottomBorderView];

        _rightBottomBorderView = [[UIView alloc] initWithFrame:CGRectZero];
        _rightBottomBorderView.backgroundColor = self.currentColor;
        [self addSubview:_rightBottomBorderView];

        GfitCameraFocusView * __weak weakSelf = self;
        [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            GfitCameraFocusView *strongSelf = weakSelf;
            strongSelf.leftBorderView.backgroundColor = otherColor;
            strongSelf.rightBorderView.backgroundColor = otherColor;
            strongSelf.leftTopBorderView.backgroundColor = otherColor;
            strongSelf.rightTopBorderView.backgroundColor = otherColor;
            strongSelf.leftBottomBorderView.backgroundColor = otherColor;
            strongSelf.rightBottomBorderView.backgroundColor = otherColor;
        } completion:^(BOOL finished) {
            if (finished) {

            }
        }];

    }
    return self;
}

- (void)layoutSubviews {
    @autoreleasepool {
        [super layoutSubviews];

        CGRect bounds = self.bounds;

        CGRect leftBorderRect = bounds;
        leftBorderRect.size.width = 1;
        self.leftBorderView.frame = leftBorderRect;

        CGRect rightBorderRect = bounds;
        rightBorderRect.origin.x = CGRectGetWidth(bounds) - 1;
        rightBorderRect.size.width = 1;
        self.rightBorderView.frame = rightBorderRect;

        CGRect leftTopBorderRect = bounds;
        leftTopBorderRect.size.height = 1;
        leftTopBorderRect.size.width = roundf(CGRectGetWidth(bounds) * kGfitCameraFocusViewExtendRange);
        self.leftTopBorderView.frame = leftTopBorderRect;

        CGRect rightTopBorderRect = bounds;
        rightTopBorderRect.size.height = 1;
        rightTopBorderRect.size.width = roundf(CGRectGetWidth(bounds) * kGfitCameraFocusViewExtendRange);
        rightTopBorderRect.origin.x = CGRectGetWidth(bounds) - CGRectGetWidth(rightTopBorderRect);
        self.rightTopBorderView.frame = rightTopBorderRect;

        CGRect leftBottomBorderRect = bounds;
        leftBottomBorderRect.size.height = 1;
        leftBottomBorderRect.size.width = roundf(CGRectGetWidth(bounds) * kGfitCameraFocusViewExtendRange);
        leftBottomBorderRect.origin.y = CGRectGetHeight(bounds) - 1;
        self.leftBottomBorderView.frame = leftBottomBorderRect;

        CGRect rightBottomBorderRect = bounds;
        rightBottomBorderRect.size.height = 1;
        rightBottomBorderRect.size.width = roundf(CGRectGetHeight(bounds) * kGfitCameraFocusViewExtendRange);
        rightBottomBorderRect.origin.y = CGRectGetHeight(bounds) - 1;
        rightBottomBorderRect.origin.x = CGRectGetWidth(bounds) - CGRectGetWidth(rightBottomBorderRect);
        self.rightBottomBorderView.frame = rightBottomBorderRect;
    }
}

@end
