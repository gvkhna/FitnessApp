//
//  GfitHorizontalSlidingTransitionDropShadowView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/8/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitHorizontalSlidingTransitionDropShadowView.h"

@interface GfitHorizontalSlidingTransitionDropShadowView ()

@property (nonatomic, strong) UIImageView *shadowImageView;

@end

@implementation GfitHorizontalSlidingTransitionDropShadowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        @autoreleasepool {
            self.backgroundColor = [UIColor whiteColor];
            
            UIImage *shadowImage = [UIImage imageNamed:@"root_navigation_drop_shadow"];

            NSParameterAssert(shadowImage != nil);

            _shadowImageView = [[UIImageView alloc] initWithImage:shadowImage];
            _shadowImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [self addSubview:_shadowImageView];
        }

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGSize shadowSize = self.shadowImageView.image.size;

    CGRect shadowFrame = self.bounds;
    shadowFrame.origin.x = -(shadowSize.width);
    shadowFrame.origin.y = 0;
    shadowFrame.size.width = shadowSize.width;
    shadowFrame.size.height = CGRectGetHeight(self.bounds);
    self.shadowImageView.frame = shadowFrame;
}

@end
