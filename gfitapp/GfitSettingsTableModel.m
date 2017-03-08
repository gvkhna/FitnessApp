//
//  GfitSettingsTableModel.m
//  gfitapp
//
//  Created by Gaurav Khanna on 4/24/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSettingsTableModel.h"
#import "GfitSettingMenuTableViewController.h"

@interface GfitSettingsTableModel () 

@end

@implementation GfitSettingsTableModel

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 10;
        case 1:
            return 1;
        case 0:
            return 3;
        default:
            return 0;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return NSLocalizedString(@"SUPPORT", nil);
        case 1:
            return NSLocalizedString(@"ABOUT GFIT", nil);
        case 0:
            return @"";
        default:
            return @"";
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return NSLocalizedString(@"GFITAPP_VERSION_STRING", nil);
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GfitSettingsTableViewControllerCellIdentifier forIndexPath:indexPath];

    // Configure the cell...

    cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];

    return cell;
}


@end
