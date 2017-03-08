//
//  GfitMenuGridCell.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitMenuGridCell.h"
#import "GfitFont.h"
#import "gfitapp-Constants.h"

#define GfitMenuGridCell_DEBUG_BACKGROUND_COLOR 0

static const CGFloat kGfitMenuGridControllerTextColor = 0.6;
static const CGFloat kGfitMenuGridControllerCellButtonTextSpacing = 1.7;

@interface GfitMenuGridCellButton : UIButton
@end
@implementation GfitMenuGridCellButton
@end


@interface GfitMenuGridCell ()

@property (nonatomic, strong) GfitMenuGridCellButton *content;

@end

@implementation GfitMenuGridCell

#pragma mark - Object Setup Methods

/**
 *  Designated initializer for setup
 *
 *  @param frame initial frame
 *
 *  @return fully initialized object
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        @autoreleasepool {
            // setup the cell
            self.clipsToBounds = YES;
            self.highlighted = NO;

    #if GfitMenuGridCell_DEBUG_BACKGROUND_COLOR
            self.backgroundColor = [UIColor blackColor];
    #else
            self.backgroundColor = [UIColor clearColor];
    #endif

            // setup the button
            _content = [GfitMenuGridCellButton buttonWithType:UIButtonTypeCustom];
            _content.exclusiveTouch = YES;
            //_content.titleLabel.backgroundColor = [UIColor whiteColor];
            //_content.titleLabel.textAlignment = NSTextAlignmentCenter;
            _content.titleLabel.opaque = YES;
            _content.titleLabel.backgroundColor = [UIColor whiteColor];
            _content.userInteractionEnabled = NO;
            _content.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
            _content.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            [_content setTitleColor:[GfitColor colorWithWhite:kGfitMenuGridControllerTextColor alpha:1] forState:UIControlStateNormal];
//            [_content setTitleColor:[GfitColor colorWithWhite:kGfitTextHighlightColor alpha:1] forState:UIControlStateHighlighted];
            // set the button as the cell's object and add as subview
            [self.contentView addSubview:_content];
        }
    }
    return self;
}

#pragma mark - Cell Layout Methods

/**
 *  Positions the icon above the text centered
 *
 *  @note default preferredFont for text is 12.0 system regular font
 */
- (void)layoutSubviews {
    @autoreleasepool {
        [super layoutSubviews];

        // button should fill frame
        self.content.frame = self.bounds;
        self.content.contentEdgeInsets = UIEdgeInsetsZero;

        NSAttributedString *title = [self.content attributedTitleForState:UIControlStateNormal];

        //self.content.titleLabel.font = [GfitFont preferredFontForTextStyle:UIFontTextStyleCaption1];

        // calculate resource metrics
        UIImage *iconImage = [self image];
        //UIFont *titleFont = self.content.titleLabel.font;
        const CGSize textSize = [title size];

        // first calculate buttonHeight with image height, text spacing, and text height
        const CGFloat imageAreaHeight = iconImage.size.height;
        const CGFloat textAreaHeight = (textSize.height * kGfitMenuGridControllerCellButtonTextSpacing);
        const CGFloat buttonHeight = imageAreaHeight + textAreaHeight;

        // center image horizontally by image width
        const CGFloat imageLeftInset = CGRectGetMidX(self.bounds) - (iconImage.size.width / 2);

        // calculate image top margin by buttonHeight
        const CGFloat imageTopMargin = CGRectGetMidY(self.bounds) - (buttonHeight / 2);
        // use top margin less text spacing and text height to arrive at inset
        const CGFloat imageBottomInset = CGRectGetHeight(self.bounds) - imageTopMargin - imageAreaHeight;

        [self.content setImageEdgeInsets:UIEdgeInsetsMake(0, round(imageLeftInset), round(imageBottomInset), 0)];

        // center text horizontally by text width
        const CGFloat textLeftMargin = CGRectGetMidX(self.bounds) - (textSize.width / 2);
        // text left inset is adjusted relative to the image, account for the image width
        const CGFloat textLeftInset = textLeftMargin - iconImage.size.width;

        // use image top margin and button height less text height to arrive at text top margin
        const CGFloat textTopMargin = imageTopMargin + buttonHeight;
        // use text top margin to arrive at inset
        const CGFloat textBottomInset = CGRectGetHeight(self.bounds) - textTopMargin;

        [self.content setTitleEdgeInsets:UIEdgeInsetsMake(0, round(textLeftInset), round(textBottomInset), 0)];
    }
}

#pragma mark - GfitMenuGridCellContent protocol methods


- (id)title {
    return [self.content attributedTitleForState:UIControlStateNormal];
}

- (void)setTitle:(NSString*)title {
    @autoreleasepool {
        UIFont *font = [GfitFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        UIColor *textColor = [UIColor colorWithWhite:kGfitMenuGridControllerTextColor alpha:1];
        UIColor *backColor = [UIColor whiteColor];

        NSDictionary *options = @{NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: textColor,
                                  NSBackgroundColorAttributeName: backColor
                                  };
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title attributes:options];

        [self.content setAttributedTitle:attrString forState:UIControlStateNormal];
    }
}

- (id)image {
    return [self.content imageForState:UIControlStateNormal];
}

- (void)setImage:(UIImage*)image {
    [self.content setImage:image forState:UIControlStateNormal];
}

@end
