//
//  GfitSearchTableViewCell.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/23/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GfitSearchTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL *separator;

- (void)setTopCornersRounded:(BOOL)rounded;
- (void)setBottomCornersRounded:(BOOL)rounded;

@end
