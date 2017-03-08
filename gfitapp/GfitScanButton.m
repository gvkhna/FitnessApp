//
//  GfitScanButton.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/4/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitScanButton.h"
#import "GfitFont.h"
#import "gfitapp-Constants.h"

@implementation GfitScanButton

- (void)g_setup {
    self.userInteractionEnabled = NO;
    UIImage *backgroundImage = [UIImage imageNamed:@"button_scan_bg"];

    NSParameterAssert(backgroundImage != nil);

    UIImage *background = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];

    UIImage *scanButtonIcon = [UIImage imageNamed:@"button_scan_icon"];

    NSParameterAssert(scanButtonIcon != nil);

    //self.exclusiveTouch = YES;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [self setImage:scanButtonIcon forState:UIControlStateNormal];
    [self setBackgroundImage:background forState:UIControlStateNormal];

    UIFont *titleFont = [GfitFont g_preferredCustomFontForTextStyleBody];

    NSParameterAssert(titleFont != nil);

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;

    self.titleLabel.adjustsFontSizeToFitWidth = NO;

    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Scan Code" value:nil table:@"LocalizableStartup"];
    UIColor *titleNormalColor = [UIColor colorWithWhite:kGfitTextPlaceholderColor alpha:1];
    UIColor *titleNormalBackgroundColor = [UIColor whiteColor];
    NSDictionary *normalDict = @{NSFontAttributeName: titleFont,
                                 NSParagraphStyleAttributeName: paragraphStyle,
                                 NSForegroundColorAttributeName: titleNormalColor,
                                 NSBackgroundColorAttributeName: titleNormalBackgroundColor};
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:title attributes:normalDict];
    [self setAttributedTitle:titleString forState:UIControlStateNormal];

    UIColor *titleHighlightColor = [UIColor colorWithWhite:kGfitTextHighlightColor alpha:1];
    UIColor *titleHighlightBackgroundColor = [UIColor colorWithWhite:0.533 alpha:1.000];
    NSDictionary *highlightDict = @{NSFontAttributeName: titleFont,
                                    NSParagraphStyleAttributeName: paragraphStyle,
                                    NSForegroundColorAttributeName: titleHighlightColor,
                                    NSBackgroundColorAttributeName: titleHighlightBackgroundColor};
    NSAttributedString *highlightString = [[NSAttributedString alloc] initWithString:title attributes:highlightDict];
    [self setAttributedTitle:highlightString forState:UIControlStateHighlighted];

    self.titleLabel.opaque = YES;
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.accessibilityIdentifier = title;

    self.blankingView = [[UIView alloc] initWithFrame:CGRectZero];
    self.blankingView.backgroundColor = [UIColor whiteColor];
    self.blankingView.opaque = YES;
    self.blankingView.userInteractionEnabled = NO;
    [self addSubview:self.blankingView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.blankingView.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(4.5, 5.5, 6.5, 5.5));
    self.blankingView.hidden = self.highlighted;

    self.contentEdgeInsets = UIEdgeInsetsZero;

    UIEdgeInsets insets = UIEdgeInsetsMake(3.5, 3.5, 3.5, 3.5);

    // moves icon and title label to proper center
    CGFloat verticalCenterAdjustment = insets.bottom - insets.top; //contentInsets.bottom - contentInsets.top;

    //DLogCGFloat(verticalCenterAdjustment);

    UIImage *iconImage = self.currentImage;

    // set the image left inset
    CGFloat iconInset = 16.5;
    [self setImageEdgeInsets:UIEdgeInsetsMake(verticalCenterAdjustment, iconInset, 0, 0)];

    // set the text left inset
    CGFloat textInset = 69.5;
    // account for the icon width
    CGFloat textInsetFixed  = textInset - iconImage.size.width;

    [self setTitleEdgeInsets:UIEdgeInsetsMake(verticalCenterAdjustment, textInsetFixed, 0, 0)];

    [self bringSubviewToFront:self.titleLabel];
    [self bringSubviewToFront:self.imageView];
}

//- (CGRect)backgroundRectForBounds:(CGRect)bounds;
//- (CGRect)contentRectForBounds:(CGRect)bounds;

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    titleRect.size.height -= 1;
    titleRect.size.width -= 1;
    return titleRect;
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect;

@end
