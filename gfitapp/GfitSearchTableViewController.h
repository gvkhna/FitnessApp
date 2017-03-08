//
//  GfitSearchTableViewController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/23/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GfitSearchTableViewControllerCancelGestureProtocol.h"

static const CGFloat kGfitSearchTableViewTopMargin = 96.0f;
static const CGFloat kGfitSearchTableViewRowHeight = 46.0f;
static NSString *GfitSearchTableViewCellIdentifier = @"GfitSearchTableViewCell";

@interface GfitSearchTableViewController : UITableViewController

/**
 *  Designated `GfitSearchTableViewController` initializer
 *
 *  @return fully setup `GfitSearchTableViewController` object
 */
- (instancetype)initWithSearchTableViewStyle;

@property (nonatomic, weak) id<GfitSearchTableViewControllerCancelGestureProtocol> searchCancelDelegate;
@property (nonatomic, weak) id<UITableViewDataSource> searchResultsModel;

@end
