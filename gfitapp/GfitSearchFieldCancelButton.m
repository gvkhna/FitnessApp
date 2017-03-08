//
//  GfitSearchFieldCancelButton.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/4/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchFieldCancelButton.h"
#import "GfitBezierTimingLayer.h"
#import "UIColor+GfitImage.h"
#import "gfitapp-Constants.h"

@interface GfitSearchFieldCancelButtonHighlightImageView : UIImageView

@end

@implementation GfitSearchFieldCancelButtonHighlightImageView

@end

@interface GfitSearchFieldCancelButton ()

@property (nonatomic, strong) GfitSearchFieldCancelButtonHighlightImageView *cancelHighlightImageView;

@end

@implementation GfitSearchFieldCancelButton

//+ (Class)layerClass {
//    return [GfitBezierTimingLayer class];
//}

- (void)g_setup {
    UIColor *clearColor = [UIColor clearColor];

    UIImage *cancelHightlightImage = [[UIImage imageNamed:@"button_cancel_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    self.cancelHighlightImageView = [[GfitSearchFieldCancelButtonHighlightImageView alloc] initWithImage:cancelHightlightImage];
    self.cancelHighlightImageView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    self.cancelHighlightImageView.hidden = YES;
    [self addSubview:self.cancelHighlightImageView];


    // Cancel Button
    NSString *cancelText = [[NSBundle mainBundle] localizedStringForKey:@"CANCEL" value:nil table:@"LocalizableStartup"];

    NSParameterAssert(cancelText != nil);

    UIColor *cancelTextColor = [UIColor colorWithWhite:kGfitTextPlaceholderColor alpha:1];
    UIColor *cancelHighlight = [UIColor colorWithWhite:kGfitTextHighlightColor alpha:1];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;

    NSDictionary *titleDict = @{NSParagraphStyleAttributeName: paragraphStyle,
                                NSBackgroundColorAttributeName: clearColor,
                                NSForegroundColorAttributeName: cancelTextColor
                                };

    NSDictionary *highlightDict = @{NSParagraphStyleAttributeName: paragraphStyle,
                                    NSBackgroundColorAttributeName: clearColor,
                                    NSForegroundColorAttributeName: cancelHighlight
                                    };


    NSAttributedString *title = [[NSAttributedString alloc] initWithString:cancelText attributes:titleDict];
    NSAttributedString *highlight = [[NSAttributedString alloc] initWithString:cancelText attributes:highlightDict];

    UIImage *cancelIcon = [[UIColor colorWithWhite:0.867 alpha:1] g_imageWithoutAlpha];

    
    self.exclusiveTouch = YES;
    self.backgroundColor = clearColor;
    self.opaque = NO;
    //self.hidden = YES;
    self.exclusiveTouch = YES;
    [self setImage:cancelIcon forState:UIControlStateNormal];
    [self setBackgroundImage:cancelHightlightImage forState:UIControlStateHighlighted];
    [self setAttributedTitle:title forState:UIControlStateNormal];
    [self setAttributedTitle:highlight forState:UIControlStateHighlighted];
    self.layer.anchorPoint = CGPointMake(0.0, 0.5);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize result = [super sizeThatFits:size];
    result.width += self.titleEdgeInsets.left + self.titleEdgeInsets.right;
    return result;
}

- (void)layoutSubviews {
    @autoreleasepool {
        [super layoutSubviews];

        [self sendSubviewToBack:self.imageView];
        [self sendSubviewToBack:self.titleLabel];

    }
}

//
//- (CGSize)intrinsicContentSize {
//    CGSize sizeIntrinsic = [super intrinsicContentSize];
//    DLogCGSize(sizeIntrinsic);
//    return sizeIntrinsic;
//}

//- (CGRect)contentRectForBounds:(CGRect)bounds {
//    CGRect rect = [super contentRectForBounds:bounds];
//
//    DLogCGRect(bounds);
//    DLogCGRect(rect);
//
//    rect.size.width += 20;
//
//    return rect;
//}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    contentRect = UIEdgeInsetsInsetRect(contentRect, UIEdgeInsetsMake(8.5, 0, 8.5, 0));
    contentRect.size.width = 1;

    return contentRect;
}

@end
