//
//  UIView+GDropShadow.m
//  gfitapp
//
//  Created by Gaurav Khanna on 10/3/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "UIView+GDropShadow.h"

@implementation UIView (GDropShadow)

- (void)g_setShadow:(BOOL)shadow animated:(BOOL)animated {
    @autoreleasepool {
        UIView * __weak weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *strongSelf = weakSelf;

            // have to enforce on `UIView` object otherwise shadow won't show
            strongSelf.clipsToBounds = NO;

            if (!strongSelf.layer.shadowPath) {
                strongSelf.layer.shadowPath = [UIBezierPath bezierPathWithRect:strongSelf.bounds].CGPath;
                strongSelf.layer.shadowOffset = CGSizeZero;
                strongSelf.layer.shadowRadius = 5.0f;
                strongSelf.layer.shadowColor = [UIColor blackColor].CGColor;
                strongSelf.layer.shadowOpacity = 0.0f;
            }

            if (animated) {
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
                animation.duration = 1.0f;
                animation.fromValue = [NSNumber numberWithFloat:!shadow];
                animation.toValue = [NSNumber numberWithFloat:shadow];
                [strongSelf.layer addAnimation:animation forKey:@"shadowOpacity"];
            }
            
            strongSelf.layer.shadowOpacity = shadow;
        });
    }
}


@end
