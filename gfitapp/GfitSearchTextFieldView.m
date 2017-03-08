//
//  GfitSearchTextFieldView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchTextFieldView.h"
#import "GfitSearchTextFieldView.h"
#import "GfitSearchField.h"
#import "GfitSearchFieldCancelButton.h"
#import "UIColor+GfitImage.h"
#import "UIView+GAnimateBlock.h"
#import "GfitFont.h"
#import "gfitapp-Constants.h"

const CGFloat kGfitSearchFieldViewTopMargin = 31;
const CGFloat kGfitSearchFieldViewInset = 3.5;

const CGFloat kGfitSearchFieldIconInset = 19.5;
const CGFloat kGfitSearchFieldTextInset = 22.0;

@interface GfitSearchFieldBackgroundImageView : UIImageView

@end

@implementation GfitSearchFieldBackgroundImageView

@end

@interface GfitSearchTextFieldView () <UITextFieldDelegate>

@property (nonatomic, strong) GfitSearchField *searchField;
@property (nonatomic, strong) GfitSearchFieldBackgroundImageView *backgroundImageView;
@property (nonatomic, strong) GfitSearchFieldCancelButton *searchCancelButton;

@end

@implementation GfitSearchTextFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIColor *clearColor = [UIColor clearColor];

        self.backgroundColor = clearColor;

        _searchField = [[GfitSearchField alloc] initWithFrame:frame];
        _searchField.delegate = self;
        //_searchField.hidden = YES;
        _searchField.exclusiveTouch = YES;
        [self addSubview:_searchField];


        // Search Field Background Image
        UIImage *fieldBackground = [UIImage imageNamed:@"button_search_bg"];

        NSParameterAssert(fieldBackground != nil);

        UIImage *backgroundImage = [fieldBackground resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];

        _backgroundImageView = [[GfitSearchFieldBackgroundImageView alloc] initWithImage:backgroundImage];
        //_backgroundImageView.hidden = YES;
        [self addSubview:_backgroundImageView];


        _searchCancelButton = [GfitSearchFieldCancelButton buttonWithType:UIButtonTypeCustom];
        [_searchCancelButton g_setup];

        [_searchCancelButton addTarget:self action:@selector(handleSearchCancel:) forControlEvents:UIControlEventTouchUpInside];
        _searchCancelButton.enabled = YES;

        [self addSubview:_searchCancelButton];

        //NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        //[center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.window];
    }
    return self;
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)layoutSubviews {
    [super layoutSubviews];

    const UIEdgeInsets backgroundInsets = UIEdgeInsetsMake(kGfitSearchFieldViewInset, kGfitSearchFieldViewInset, kGfitSearchFieldViewInset, kGfitSearchFieldViewInset);
    self.backgroundImageView.frame = UIEdgeInsetsInsetRect(self.bounds, backgroundInsets);

    const UIEdgeInsets fieldInsets = UIEdgeInsetsMake(8, 9, 10, 9);
    self.searchField.frame = UIEdgeInsetsInsetRect(self.bounds, fieldInsets);
    self.searchField.font = [GfitFont preferredFontForTextStyle:UIFontTextStyleBody];

    //[self.searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    //[self.searchButton setTitleEdgeInsets:UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)]

    //[self.searchCancelButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [self.searchCancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 14, 0, 14)];

    GfitSearchTextFieldView * __weak weakSelf = self;

    // Size to fit the text width
    [UIView performWithoutAnimation:^{
        GfitSearchTextFieldView *strongSelf = weakSelf;

        [weakSelf.searchCancelButton sizeToFit];

        // expand height to fill text field
        CGRect searchCancelRect = UIEdgeInsetsInsetRect(strongSelf.searchField.frame, UIEdgeInsetsMake(-1, 0, -1, 2));
        searchCancelRect.size.width = CGRectGetWidth(strongSelf.searchCancelButton.frame);
        strongSelf.searchCancelButton.frame = searchCancelRect;

    }];

    // setup for editing
    CGPoint showingCancel = CGPointMake(CGRectGetWidth(self.searchField.frame) + self.searchField.frame.origin.x, self.searchField.center.y);
    CGPoint hidingCancel = CGPointMake(showingCancel.x - CGRectGetWidth(self.searchCancelButton.frame) + [self.searchCancelButton imageRectForContentRect:self.searchCancelButton.frame].size.width, showingCancel.y);

    //DLogBOOL(self.searchField.editing);
    //DLogBOOL(self.transitioning);
    //if (YES) {//if (self.searching) {
        //[UIView performWithoutAnimation:^{
        self.searchCancelButton.center = showingCancel;
        //}];
        self.searchCancelButton.center = hidingCancel;
//    } else {
//        //[UIView performWithoutAnimation:^{
//        self.searchCancelButton.center = hidingCancel;
//        //}];
//        self.searchCancelButton.center = showingCancel;
//    }

    [self bringSubviewToFront:self.backgroundImageView];
    [self bringSubviewToFront:self.searchField];
    [self bringSubviewToFront:self.searchCancelButton];
}

- (CGSize)intrinsicContentSize {
    const CGSize imageSize = self.backgroundImageView.image.size;
    const CGFloat contentWidth = imageSize.width + (kGfitSearchFieldViewInset*2);
    const CGFloat contentHeight = imageSize.height + (kGfitSearchFieldViewInset*2);
    return CGSizeMake(contentWidth, contentHeight);
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

#pragma mark - Keyboard Notifications

//- (void)keyboardWillShow:(NSNotification *)notif {
//    GfitSearchTextFieldView * __weak weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [weakSelf showCancel:YES animated:YES];
//    });
//}

#pragma mark - UITextField delegate methods

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//
//    DLogFunctionLine();
//
//    GfitSearchButtonView * __weak weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [weakSelf showCancel:YES animated:YES];
//    });
//
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//
//    GfitSearchButtonView * __weak weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        GfitSearchButtonView *strongSelf = weakSelf;
//        strongSelf.searchField.text = nil;
//        strongSelf.searchField.attributedText = nil;
//        [strongSelf showCancel:NO animated:YES];
//    });
//
//}

- (void)handleSearchCancel:(id)sender {
    GfitSearchTextFieldView * __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        GfitSearchTextFieldView *strongSelf = weakSelf;

        [[UIApplication sharedApplication] sendAction:@selector(searchCancel:) to:nil from:strongSelf forEvent:[UIEvent new]];
        strongSelf.searchCancelButton.enabled = NO;
        strongSelf.searchField.text = nil;
        strongSelf.searchField.attributedText = nil;
        //[strongSelf showCancel:NO animated:YES];
    });
}
//
//#pragma mark - View update animations
//
//- (void)showCancel:(BOOL)show animated:(BOOL)animated {
//
//    GfitSearchTextFieldView * __weak weakSelf = self;
//    [UIView g_performAnimations:animated blockOperation:[NSBlockOperation blockOperationWithBlock:^{
//        GfitSearchTextFieldView *strongSelf = weakSelf;
//
//        //strongSelf.searching = show;
//
//        if (show) {
//            [[UIApplication sharedApplication] sendAction:@selector(search:) to:nil from:strongSelf forEvent:nil];
//        } else {
//            [[UIApplication sharedApplication] sendAction:@selector(searchCancel:) to:nil from:strongSelf forEvent:nil];
//        }
//
//        strongSelf.searchCancelButton.hidden = NO;
//        strongSelf.searchCancelButton.userInteractionEnabled = NO;
//
//        [strongSelf setNeedsLayout];
//        [strongSelf layoutIfNeeded];
//
//        [UIView animateWithDuration:kGfitTransitionFastTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            GfitSearchTextFieldView *strongSelf = weakSelf;
//
//            [strongSelf setNeedsLayout];
//            [strongSelf layoutIfNeeded];
//
//        } completion:^(BOOL finished) {
//            if (finished) {
//                GfitSearchTextFieldView *strongSelf = weakSelf;
//
//                [strongSelf setNeedsLayout];
//                [strongSelf layoutIfNeeded];
//
//                if (show) {
//                    strongSelf.searchCancelButton.userInteractionEnabled = YES;
//                } else {
//                    strongSelf.searchCancelButton.hidden = YES;
//                }
//            }
//        }];
//        
//    }]];
//    
//}

@end
