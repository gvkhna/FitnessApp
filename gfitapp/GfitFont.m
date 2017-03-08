//
//  GfitFont.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/1/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitFont.h"

@implementation GfitFont

static const CGFloat kGFontDynamicStyleMedium = 18.0;

+ (GfitFont *)g_preferredCustomFontForTextStyleBody {
    @autoreleasepool {
        NSString *contentSize = [UIApplication sharedApplication].preferredContentSizeCategory;

        if (![contentSize isEqualToString:UIContentSizeCategoryMedium]) {
            return (GfitFont *)[GfitFont preferredFontForTextStyle:UIFontTextStyleBody];
        }

        NSNumber *size = [[NSNumber alloc] initWithFloat:kGFontDynamicStyleMedium];
        NSNumber * __weak weakSize = size;
        NSDictionary *options = @{UIFontDescriptorSizeAttribute: weakSize};
        UIFontDescriptor *medium = [[UIFontDescriptor alloc] initWithFontAttributes:options];
        return (GfitFont *)[GfitFont fontWithDescriptor:medium size:kGFontDynamicStyleMedium];
    }
}

@end
