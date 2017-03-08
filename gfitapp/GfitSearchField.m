//
//  GfitSearchField.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchField.h"
#import "GfitFont.h"


@interface GfitSearchFieldMagnifyingGlassImageView : UIImageView

@end

@implementation GfitSearchFieldMagnifyingGlassImageView

@end

static const CGFloat kGfitSearchFieldIconInset = 19.5;
static const CGFloat kGfitSearchFieldTextInset = 22.0;

@implementation GfitSearchField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Magnifying Glass Icon
        UIImage *fieldIconImage = [UIImage imageNamed:@"button_search_icon"];

        NSParameterAssert(fieldIconImage != nil);

        GfitSearchFieldMagnifyingGlassImageView *fieldIconImageView = [[GfitSearchFieldMagnifyingGlassImageView alloc] initWithImage:fieldIconImage];


        NSString *text = [[NSBundle mainBundle] localizedStringForKey:@"Search"
                                                                value:nil
                                                                table:@"LocalizableStartup"];

        NSParameterAssert(text != nil);

        UIFont *searchFieldFont = [GfitFont preferredFontForTextStyle:UIFontTextStyleBody];

        NSParameterAssert(searchFieldFont != nil);

        UIColor *whiteColor = [UIColor whiteColor];
        UIColor *placeholderColor = [UIColor colorWithWhite:0.729 alpha:1.000];

        NSDictionary *options = @{NSFontAttributeName: searchFieldFont,
                                  NSBackgroundColorAttributeName: whiteColor
                                  };

        NSDictionary *placeholderDict = @{NSFontAttributeName: searchFieldFont,
                                          NSBackgroundColorAttributeName: whiteColor,
                                          NSForegroundColorAttributeName: placeholderColor,
                                          };

        NSAttributedString *holder = [[NSAttributedString alloc] initWithString:text attributes:placeholderDict];



        // UITextField properties
        self.attributedPlaceholder = holder;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.accessibilityIdentifier = text;
        self.defaultTextAttributes = options;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = fieldIconImageView;

        // UIControl properties
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        // UIView properties
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = whiteColor;
        self.opaque = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSArray *subviews = [self subviews];
    for (UIView *view in subviews) {
        view.opaque = YES;
        view.backgroundColor = [UIColor whiteColor];
    }

//    NSArray *arr = [self.layer sublayers];
//    for (CALayer *layer in arr) {
//        layer.opaque = YES;
//        layer.backgroundColor = [UIColor whiteColor].CGColor;
//    }
}

////- (CGRect)borderRectForBounds:(CGRect)bounds;

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(textRect, UIEdgeInsetsMake(0.5, kGfitSearchFieldTextInset, -0.5, kGfitSearchFieldTextInset));
}

//- (CGRect)placeholderRectForBounds:(CGRect)bounds {
//    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
//    return UIEdgeInsetsInsetRect(placeholderRect, UIEdgeInsetsMake(0, kGfitSearchFieldTextInset, 0, -kGfitSearchFieldTextInset));
//}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editingRect = [super editingRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(editingRect, UIEdgeInsetsMake(0, kGfitSearchFieldTextInset, 0, -kGfitSearchFieldTextInset));
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    return CGRectZero;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect leftViewRect = [super leftViewRectForBounds:bounds];
    return UIEdgeInsetsInsetRect(leftViewRect, UIEdgeInsetsMake(-0.5, kGfitSearchFieldIconInset, 0.5, -kGfitSearchFieldIconInset));
}

//- (CGRect)rightViewRectForBounds:(CGRect)bounds {
//    CGRect rightRect = [super rightViewRectForBounds:bounds];
//    CGSize rightSize = self.rightView.intrinsicContentSize;
//    rightSize = CGSizeMake(50, 50);
//    UIEdgeInsets rightInsets = UIEdgeInsetsMake(0, -rightSize.width, 0, rightSize.width);
//    CGRect ret = UIEdgeInsetsInsetRect(rightRect, rightInsets);
//    return CGRectMake(0, 0, rightSize.width, rightSize.height);
//}

@end
