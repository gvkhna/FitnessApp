//
//  GfitMenuGridControllerDelegate.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/18/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GfitMenuGridControllerDelegate <NSObject>
@required
/**
 *  Action method for the icon selected event
 *
 *  @param indexPath the `NSIndexPath` object specifying the row of the item
 */
- (void)gridControllerDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
