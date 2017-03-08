//
//  GfitMenuGridControllerDataSource.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GfitMenuGridCellContent <NSObject>
@required
/**
 *  Set the `UICollectionViewCell`s contentView `UIButton` object's title at UIControlStateNormal
 *
 *  @note title the `NSString` object to [cell.button setTitle:title forState:UIControlStateNormal]
 */
@property (nonatomic, readwrite, copy) NSString *title;

/**
 *  Set the `UICollectionViewCell`s contentView `UIButton` object's image at UIControlStateNormal
 *
 *  @note image the `UIImage` object to [cell.button setImage:image forState:UIControlStateNormal]
 */
@property (nonatomic, readwrite, copy) UIImage *image;


/**
 *  The `UICollectionViewCell`s contentView property object
 *
 *  @note you can attach for example a UITapGestureRecognizer and set the delegate's message as nop
 */
@property (nonatomic, readonly) UIView *contentView;

@end

@protocol GfitMenuGridControllerDataSource <NSObject>
@required

/**
 *  icon and text is collected to display in the grid
 *
 *  @param cell the `GfitMenuGridCell` object that is the content of that indexPath.row
 *  @param indexPath the `NSIndexPath` object specifying the row of the item
 */
- (void)gridControllerWillDisplayCell:(id <GfitMenuGridCellContent>)cell atIndexPath:(NSIndexPath *)indexPath;

@end

