//
//  GfitSearchView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchView.h"
#import "GfitSearchViewController.h"


@interface GfitSearchView () <GfitSearchViewControllerViewProtocol>

@end

@implementation GfitSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //UIColor *clearColor = [UIColor clearColor];

        self.backgroundColor = [UIColor whiteColor];

        UIImage *searchBackgroundImage = [UIImage imageNamed:@"search_landscape_bg"];

        NSParameterAssert(searchBackgroundImage != nil);

        _searchViewBackgroundImageView = [[UIImageView alloc] initWithImage:searchBackgroundImage];
        //_searchViewBackgroundImageView.alpha = 0;
        [self addSubview:_searchViewBackgroundImageView];

        // create search field
        _searchTextFieldView = [[GfitSearchTextFieldView alloc] initWithFrame:CGRectZero];
        _searchTextFieldView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_searchTextFieldView];

        //[self.searchTextFieldView]


    }
    return self;
}

- (void)didSetSearchTableViewController {
    [self addSubview:self.searchTableViewController.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    const CGFloat width = CGRectGetWidth(self.bounds);

//    const CGSize backgroundSize = self.searchViewBackgroundImageView.image.size;
//    self.searchViewBackgroundImageView.frame = CGRectMake(0, 0, backgroundSize.width, backgroundSize.height);

    const CGFloat searchTextFieldTopMargin = self.searchTextFieldView.topLayoutGuide.length;
    const CGSize searchTextFieldViewSize = self.searchTextFieldView.intrinsicContentSize;
    self.searchTextFieldView.frame = CGRectMake(0, searchTextFieldTopMargin, width, searchTextFieldViewSize.height);

    CGRect searchViewRect = self.bounds;
    searchViewRect.origin.y = self.searchTableViewController.topLayoutGuide.length;
    searchViewRect.size.height = CGRectGetHeight(self.bounds) - self.searchTableViewController.topLayoutGuide.length;
    self.searchTableViewController.view.frame = searchViewRect;

    [self bringSubviewToFront:self.searchViewBackgroundImageView];
    [self bringSubviewToFront:self.searchTextFieldView];
    [self bringSubviewToFront:self.searchTableViewController.view];
}

@end
