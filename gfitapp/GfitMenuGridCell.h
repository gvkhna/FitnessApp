//
//  GfitMenuGridCell.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitMenuGridControllerDataSource.h"

@interface GfitMenuGridCell : UICollectionViewCell <GfitMenuGridCellContent>

/**
 *  The main content of the cell that extends to the bounds
 */
@property (nonatomic, readonly) UIButton *content;

@end
