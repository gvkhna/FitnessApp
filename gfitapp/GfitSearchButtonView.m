//
//  GfitSearchButtonView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchButtonView.h"
#import "GfitSearchField.h"
#import "GfitSearchTextFieldView.h"
#import "GfitSearchFieldCancelButton.h"
#import "GfitSearchButton.h"
#import "UIView+GAnimateBlock.h"
#import "GfitFont.h"
#import "UIColor+GfitImage.h"
#import "gfitapp-Constants.h"

@interface GfitsearchFieldBackgroundImageView : UIImageView

@end

@implementation GfitsearchFieldBackgroundImageView

@end

@interface GfitSearchButtonView () <UILayoutSupport>

@property (nonatomic, strong) GfitSearchButton *searchButton;

//@property (nonatomic, assign) BOOL searching;

@end

@implementation GfitSearchButtonView

#pragma mark - Object Setup Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        @autoreleasepool {
            UIColor *clearColor = [UIColor clearColor];

            self.backgroundColor = clearColor;

            _searchButton = [GfitSearchButton buttonWithType:UIButtonTypeCustom];
            [_searchButton g_setup];
            [self addSubview:_searchButton];

        }
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    const CGSize imageSize = self.searchButton.currentBackgroundImage.size;
    const CGFloat contentWidth = imageSize.width + (kGfitSearchFieldViewInset*2);
    const CGFloat contentHeight = imageSize.height + (kGfitSearchFieldViewInset*2);
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(contentWidth, contentHeight);
    }
    return CGSizeMake(contentWidth - 10, contentHeight);

}

#pragma mark - UILayoutSupport Protocol Methods

- (id<UILayoutSupport>)topLayoutGuide {
    return self;
}

- (CGFloat)length {
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        return kGfitSearchFieldViewTopMargin;
    }
    return kGfitSearchFieldViewTopMargin - 7;

}

#pragma mark - View Layout Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    const UIEdgeInsets backgroundInsets = UIEdgeInsetsMake(kGfitSearchFieldViewInset, kGfitSearchFieldViewInset, kGfitSearchFieldViewInset, kGfitSearchFieldViewInset);

    self.searchButton.frame = UIEdgeInsetsInsetRect(self.bounds, backgroundInsets);
}


#pragma mark - UIView hit test methods

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *superHitTestView = [super hitTest:point withEvent:event];
//    DLogObject(superHitTestView);
//    if (superHitTestView == self.searchCancelButton) {
//        return self.searchCancelButton;
//    }
//    return self.searchField;
//}



@end
