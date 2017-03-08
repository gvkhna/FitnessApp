//
//  GfitMenuGridController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitMenuGridControllerDataSource.h"
#import "GfitMenuGridControllerDelegate.h"

typedef NS_ENUM(NSInteger, GfitMenuGridControllerCellPosition) {
    GfitMenuGridControllerCellPositionTopLeft,
    GfitMenuGridControllerCellPositionTopRight,
    GfitMenuGridControllerCellPositionBottomLeft,
    GfitMenuGridControllerCellPositionBottomRight
};

@interface GfitMenuGridController : UICollectionViewController <UILayoutSupport>

/**
 *  Sets the detaSource object that must conform to the GMenuGridControllerDataSource protocol
 */
@property (nonatomic, weak) id <GfitMenuGridControllerDataSource> dataSource;

/**
 *  Sets the delegate object that must conform to the GMenuGridControllerDelegate protocol
 */
@property (nonatomic, weak) id <GfitMenuGridControllerDelegate> delegate;

- (CGRect)preferredContentFrame:(CGRect)bounds;

/**
 *  Designated initializer
 *
 *  @note make sure to set self.automaticallyAdjustsScrollViewInsets = NO;
 *  on the parent container view controller otherwise view may be incorrectly positioned
 * 
 *  @note the `UICollectionView` is a `UIScrollView` and will get
 *
 *  @return fully initialized object
 */
- (instancetype)initWithDataSource:(id <GfitMenuGridControllerDataSource>)dataSource;

/**
 *  View Controller Layout support for bottomLayoutGuide
 *
 *  @note here's an example of how to layout this class in layoutSubviews
 *  
 *  const CGFloat viewHeight = CGRectGetHeight(self.bounds)
 *  const CGFloat gridBottomMargin = self.menuGridController.bottomLayoutGuide.length;
 *  const CGSize gridSize = self.menuGridController.preferredContentSize;
 *  CGRect gridFrame = CGRectMake(0, viewHeight - gridSize.height - gridBottomMargin, gridSize.width, gridSize.height);
 *  self.menuGridController.view.frame = gridFrame;
 *
 *  @return object implementing protocol
 */
- (id<UILayoutSupport>)bottomLayoutGuide;

@end
