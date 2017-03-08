//
//  GfitScanButtonView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitScanButtonView.h"
#import "GfitScanButton.h"

static const CGFloat kGfitScanButtonViewTopMargin = 107;
static const CGFloat kGfitScanButtonViewInset = 3.5;


@interface GfitScanButtonView () <UILayoutSupport>

@property (nonatomic, strong) GfitScanButton *scanButton;
@property (nonatomic, strong) UIView *blankView;

@end

@implementation GfitScanButtonView

#pragma mark - Object Setup Methods

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        @autoreleasepool {
            self.backgroundColor = [UIColor clearColor];

            _scanButton = [GfitScanButton buttonWithType:UIButtonTypeCustom];
            [_scanButton g_setup];
            //[_scanButton addTarget:nil action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_scanButton];
            
        }

    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize imageSize = self.scanButton.currentBackgroundImage.size;
    CGFloat contentWidth = imageSize.width + (kGfitScanButtonViewInset*2);
    CGFloat contentHeight = imageSize.height + (kGfitScanButtonViewInset*2);
    return CGSizeMake(contentWidth, contentHeight);
}

#pragma mark - UILayoutSupport Protocol Methods

- (id<UILayoutSupport>)topLayoutGuide {
    return self;
}

- (CGFloat)length {
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        return kGfitScanButtonViewTopMargin;
    }
    return kGfitScanButtonViewTopMargin - 17;
}

#pragma mark - View Layout Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    UIEdgeInsets insets = UIEdgeInsetsMake(kGfitScanButtonViewInset, kGfitScanButtonViewInset, kGfitScanButtonViewInset, kGfitScanButtonViewInset);

    self.scanButton.frame = UIEdgeInsetsInsetRect(self.bounds, insets);
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *superHitTestView = [super hitTest:point withEvent:event];
//    if (superHitTestView == self) {
//        return self.scanButton;
//    }
//    return superHitTestView;
//}

@end
