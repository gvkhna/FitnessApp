//
//  GfitMenuGridControllerView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/5/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitMenuGridControllerView.h"
#import "GfitMenuGridLayout.h"

static const CGFloat kGfitMainScreenImageHeight = 337;
static const CGFloat kGfitMenuGridControllerTopInset = 45;
static const CGFloat kGfitMenuGridControllerTopMargin = kGfitMainScreenImageHeight - kGfitMenuGridControllerTopInset;

@implementation GfitMenuGridControllerView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (CGSize)sizeThatFits:(CGSize)size {
    //CGSize b = [super sizeThatFits:size];

    DLogCGSize(size);
    CGSize preferredSize = size;
    DLogCGSize(preferredSize);
    DLogCGSize(CGSizeMake(preferredSize.width, preferredSize.height - kGfitMenuGridControllerTopMargin - kGfitMenuGridMargin));
    return CGSizeMake(preferredSize.width, preferredSize.height - kGfitMenuGridControllerTopMargin - kGfitMenuGridMargin);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
