//
//  GfitCameraView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/21/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitCameraView.h"
#import "GfitCameraFocusView.h"

const CGFloat kGfitCameraViewFocusAnimationMultiplier = 1.2;

@interface GfitCameraView ()

@property (nonatomic, strong) GfitCameraFocusView *focusAnimationView;
@property (nonatomic, assign, getter = isFocused) BOOL focused;

@end

@implementation GfitCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _focusAnimationView = [[GfitCameraFocusView alloc] initWithFrame:CGRectZero];
        [self addSubview:_focusAnimationView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat boundsWidth = CGRectGetWidth(self.bounds);

    self.previewLayer.frame = self.layer.bounds;

    CGRect focusRect = self.bounds;
    focusRect.size.width = boundsWidth;
    focusRect.size.height = boundsWidth;
    focusRect.origin.y = CGRectGetMidY(self.bounds) - CGRectGetMidY(focusRect);

    if (!self.focused) {
        CGRect unfocusedRect = CGRectInset(focusRect, -75, -75);
        self.focusAnimationView.frame = unfocusedRect;

    } else {

        CGRect focusedRect = CGRectInset(focusRect, 25, 25);

        self.focusAnimationView.frame = focusedRect;
    }

    [self bringSubviewToFront:self.focusAnimationView];

}

- (void)didSetPreviewLayer {
    [self.layer addSublayer:self.previewLayer];
}

- (void)startFocusAnimation {

    self.focused = NO;

    [self setNeedsLayout];
    [self layoutIfNeeded];

    self.focused = YES;

    GfitCameraView * __weak weakSelf = self;
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        GfitCameraView *strongSelf = weakSelf;

        [strongSelf setNeedsLayout];
        [strongSelf layoutIfNeeded];

    } completion:^(BOOL finished) {

    }];


}

@end
