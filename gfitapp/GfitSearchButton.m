//
//  GfitSearchButton.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/30/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchButton.h"
#import "GfitFont.h"

@implementation GfitSearchButton

- (void)g_setup {
    self.userInteractionEnabled = NO;

    // Magnifying Glass Icon
    UIImage *fieldIconImage = [UIImage imageNamed:@"button_search_icon"];

    NSParameterAssert(fieldIconImage != nil);

    // Search Field Background Image
    UIImage *fieldBackground = [UIImage imageNamed:@"button_search_bg"];

    NSParameterAssert(fieldBackground != nil);

    UIImage *backgroundImage = [fieldBackground resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];

    self.exclusiveTouch = YES;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [self setImage:fieldIconImage forState:UIControlStateNormal];
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];


    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;

    self.titleLabel.adjustsFontSizeToFitWidth = NO;

    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Search"
                                                            value:nil
                                                            table:@"LocalizableStartup"];

    NSParameterAssert(title != nil);

    UIFont *searchFieldFont = [GfitFont preferredFontForTextStyle:UIFontTextStyleBody];

    NSParameterAssert(searchFieldFont != nil);

    UIColor *whiteColor = [UIColor whiteColor];
    UIColor *placeholderColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000];

//    NSDictionary *options = @{NSFontAttributeName: searchFieldFont,
//                              NSBackgroundColorAttributeName: whiteColor
//                              };

    NSDictionary *placeholderDict = @{NSFontAttributeName: searchFieldFont,
                                      NSParagraphStyleAttributeName: paragraphStyle,
                                      NSBackgroundColorAttributeName: whiteColor,
                                      NSForegroundColorAttributeName: placeholderColor,
                                      };

    NSAttributedString *holder = [[NSAttributedString alloc] initWithString:title attributes:placeholderDict];

    [self setAttributedTitle:holder forState:UIControlStateNormal];

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
    CGFloat verticalCenterAdjustment = insets.bottom - insets.top- 0.5; //contentInsets.bottom - contentInsets.top;

    //DLogCGFloat(verticalCenterAdjustment);

    UIImage *iconImage = self.currentImage;

    // set the image left inset
    CGFloat iconInset = 24.5;
    [self setImageEdgeInsets:UIEdgeInsetsMake(verticalCenterAdjustment-1.5, iconInset+0.5, 0, 0)];

    // set the text left inset
    CGFloat textInset = 63.5;
    // account for the icon width
    CGFloat textInsetFixed  = textInset - iconImage.size.width;

    [self setTitleEdgeInsets:UIEdgeInsetsMake(verticalCenterAdjustment+0.5, textInsetFixed, 0, 0)];

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
