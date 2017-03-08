//
//  GfitMainMenuGridDataSource.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/18/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuGridDataSource.h"
#import "GfitMenuGridController.h"
#import "GfitHealthViewController.h"
#import "GfitHistoryViewController.h"
#import "GfitActivityViewController.h"
#import "GfitSettingsTableViewController.h"

@implementation GfitMainMenuGridDataSource


- (void)gridControllerWillDisplayCell:(id <GfitMenuGridCellContent> )cell atIndexPath:(NSIndexPath *)indexPath {
	@autoreleasepool {
        NSBundle *mainBundle = [NSBundle mainBundle];
        switch (indexPath.row) {
            case GfitMenuGridControllerCellPositionTopLeft:
                cell.title = [mainBundle localizedStringForKey:@"HEALTH" value:nil table:@"LocalizableStartup"];
                cell.image = [UIImage imageNamed:@"menu_grid_health_icon"];
                
                break;

            case GfitMenuGridControllerCellPositionTopRight:
                cell.title = [mainBundle localizedStringForKey:@"HISTORY" value:nil table:@"LocalizableStartup"];
                cell.image = [UIImage imageNamed:@"menu_grid_history_icon"];
                break;

            case GfitMenuGridControllerCellPositionBottomLeft:
                cell.title = [mainBundle localizedStringForKey:@"ACTIVITY" value:nil table:@"LocalizableStartup"];
                cell.image = [UIImage imageNamed:@"menu_grid_activity_icon"];
                break;

            case GfitMenuGridControllerCellPositionBottomRight:
                cell.title = [mainBundle localizedStringForKey:@"SETTINGS" value:nil table:@"LocalizableStartup"];
                cell.image = [UIImage imageNamed:@"menu_grid_settings_icon"];
                break;
        }

	}
}

- (UIViewController *)mainMenuGridDidSelectItemAtIndexPath:(NSIndexPath*)indexPath {
    
    switch (indexPath.row) {
        case GfitMenuGridControllerCellPositionTopLeft:
            return [[GfitHealthViewController alloc] initWithNibName:nil bundle:nil];
        case GfitMenuGridControllerCellPositionTopRight:
            return [[GfitHistoryViewController alloc] initWithStyle:UITableViewStyleGrouped];
        case GfitMenuGridControllerCellPositionBottomLeft:
            return [[GfitActivityViewController alloc] initWithNibName:nil bundle:nil];
        case GfitMenuGridControllerCellPositionBottomRight:
            return [[GfitSettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return nil;
}

@end
