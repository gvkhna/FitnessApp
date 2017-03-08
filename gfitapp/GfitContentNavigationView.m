//
//  GfitContentNavigationView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 4/24/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitContentNavigationView.h"

@implementation GfitContentNavigationView

- (void)layoutSubviews {
    //self.frame = self.bounds;

    self.fakeNavigationBar.frame = self.realNavigationBar.frame;

    [super layoutSubviews];
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
