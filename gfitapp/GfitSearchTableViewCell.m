//
//  GfitSearchTableViewCell.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/23/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchTableViewCell.h"

@implementation GfitSearchTableViewCell

#pragma mark - Object Setup Methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _separator = YES;
        //self.textLabel.opaque = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect cellTextLabel = self.textLabel.frame;
    cellTextLabel.origin.x = 24;
    self.textLabel.frame = cellTextLabel;

}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    if (self.selected) {
//        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
//        self.textLabel.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
//        self.textLabel.backgroundColor = self.contentView.backgroundColor;
//    } else {
//        self.textLabel.textColor = [UIColor colorWithWhite:0.264 alpha:1];
//        self.contentView.backgroundColor = [UIColor colorWithWhite:0.969 alpha:1];
//        self.textLabel.backgroundColor = self.contentView.backgroundColor;
//    }
//
//}

#pragma mark - Cell Rounded Corner Methods

- (void)setTopCornersRounded:(BOOL)rounded {
    [self setCorners:YES rounded:rounded];
}

- (void)setBottomCornersRounded:(BOOL)rounded {
    [self setCorners:NO rounded:rounded];
}

- (void)setCorners:(BOOL)corners rounded:(BOOL)rounded {

    UIRectCorner corner = corners ? (UIRectCornerTopLeft | UIRectCornerTopRight) : (UIRectCornerBottomLeft | UIRectCornerBottomRight);
    if (rounded) {
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.frame = self.bounds;
        //DLogCGRect(maskLayer.bounds);
        //DLogCGRect(maskLayer.frame);
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(1.0, 1.0)].CGPath;
        //self.contentView.layer.mask = maskLayer;
        self.layer.mask = maskLayer;

        //DLogObject(maskLayer);

        CAShapeLayer *sMaskLayer = [CAShapeLayer new];
        sMaskLayer.frame = self.contentView.bounds;
        sMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds
                                                byRoundingCorners:corner
                                                      cornerRadii:CGSizeMake(1.0, 1.0)].CGPath;
        //self.selectedBackgroundView.layer.mask = sMaskLayer;
    } else {
        self.layer.mask = nil;
        //self.contentView.layer.mask = nil;
        //self.selectedBackgroundView.layer.mask = nil;
    }
}

@end
