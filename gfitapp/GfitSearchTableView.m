//
//  GfitSearchTableView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/23/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchTableView.h"
#import "GfitBezierTimingLayer.h"
#import "GfitSearchTableViewCell.h"

@interface GfitSearchTableView ()

@property (nonatomic, strong) UIImageView *separatorLineImageView;

@end

@implementation GfitSearchTableView

//+ (Class)layerClass {
//    return [GfitBezierTimingLayer class];
//}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"search_separator"];

        NSParameterAssert(image != nil);

        _separatorLineImageView = [[UIImageView alloc] initWithImage:image];
        _separatorLineImageView.hidden = YES;
        [self addSubview:_separatorLineImageView];
    }
    return self;
}

//- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGRect superFrame = [super rectForRowAtIndexPath:indexPath];
//
//    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
//    CGRect adjFrame = UIEdgeInsetsInsetRect(superFrame, edgeInsets);
//
//
//    DLogCGRect(adjFrame);
//    return adjFrame;
//}
//
//- (CGRect)rectForSection:(NSInteger)section {
//    CGRect superFrame = [super rectForSection:section];
//
//    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
//    CGRect adjFrame = UIEdgeInsetsInsetRect(superFrame, edgeInsets);
//
//
//    DLogCGRect(adjFrame);
//    return adjFrame;
//}

//- (void)setFrame:(CGRect)frame {
//    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
//    CGRect adjFrame = UIEdgeInsetsInsetRect(frame, edgeInsets);
//
//
//    [super setFrame:adjFrame];
//
//
//
//    DLogCGRect(frame);
//}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSArray *visibleIndexPaths = [self indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        CGRect fullFrame = [self rectForRowAtIndexPath:indexPath];

        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        CGRect adjFrame = UIEdgeInsetsInsetRect(fullFrame, edgeInsets);

        GfitSearchTableViewCell *cell = (GfitSearchTableViewCell*)[self cellForRowAtIndexPath:indexPath];
        [cell setFrame:adjFrame];

        UIEdgeInsets separatorInsets = UIEdgeInsetsMake(0, 24, 0, 96);
        UIEdgeInsets separatorHiddenInsets = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(cell.bounds));

        if (indexPath.row == 0) {
            cell.separatorInset = separatorInsets;
            [cell setTopCornersRounded:YES];
        } else if (indexPath.row == ([self numberOfRowsInSection:indexPath.section] -1)) {
            cell.separatorInset = separatorHiddenInsets;
            [cell setBottomCornersRounded:YES];
        } else {
            cell.separatorInset = separatorInsets;
            [cell setTopCornersRounded:NO];
        }

        cell.indentationLevel = 0;
        cell.indentationWidth = -10000;
        cell.textLabel.opaque = YES;
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }

    //if (self.contentOffset.y <= 0) {
        //self.separatorLineImageView.hidden = YES;
        self.separatorLineImageView.frame = CGRectMake(0, self.contentOffset.y, CGRectGetWidth(self.bounds), self.separatorLineImageView.image.size.height);
        [self bringSubviewToFront:self.separatorLineImageView];
//    } else {
//        self.separatorLineImageView.hidden = NO;
//    }

    //self.scrollIndicatorInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
////    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 24, 0, 24);
////    //self.contentInset = CGRectInset(self.bounds, 24.0, 0);
////    //self.contentSize = CGSizeMake(self.contentSize.width - 24, self.contentSize.height);
////    self.contentInset = UIEdgeInsetsMake(0, 8, 0, -8);
//
//
////    self.separatorLineImageView.frame = CGRectMake(0, self.contentOffset.y, CGRectGetWidth(self.bounds), self.separatorLineImageView.image.size.height);
////    [self bringSubviewToFront:self.separatorLineImageView];
//}

//#pragma mark - View Presentation Methods
//
- (void)setShowSeparatorLine:(BOOL)show {
    self.separatorLineImageView.hidden = !show;
}

@end
