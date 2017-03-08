//
//  GfitRootNavigationDropShadowView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/31/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitRootNavigationDropShadowView.h"

@interface GfitRootNavigationDropShadowView ()

@property (nonatomic, strong) UIImageView *shadowImageView;

@end

@implementation GfitRootNavigationDropShadowView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        @autoreleasepool {
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
