//
//  UIColor+GfitImage.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/15/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "UIColor+GfitImage.h"

@implementation UIColor (GfitImage)

- (UIImage *)g_imageWithAlpha {
    return [self g_imageWithAlpha:YES];
}

- (UIImage *)g_imageWithoutAlpha {
    return [self g_imageWithAlpha:NO];
}

- (UIImage *)g_imageWithAlpha:(BOOL)alpha {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, !alpha, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
