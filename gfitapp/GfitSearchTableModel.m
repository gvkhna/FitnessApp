//
//  GfitSearchTableModel.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/4/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchTableModel.h"
#import "GfitSearchTableViewController.h"
#import "GfitSearchTableViewCell.h"

@interface GfitSearchTableModel ()

@property (nonatomic, strong) NSArray *defaultStrings;

@end

@implementation GfitSearchTableModel

#pragma mark - Table view data source

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultStrings = @[@"Pull ups", @"Push ups", @"Running", @"Walking", @"Biking"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GfitSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GfitSearchTableViewCellIdentifier];

    NSAssert(cell, @"GfitSearchTableViewController could not dequeueReusableCellWithIdentifier:%@", GfitSearchTableViewCellIdentifier);

    // Configure the cell.

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;

    UIColor *clearColor = [UIColor whiteColor];
    UIColor *blackColor = [UIColor blackColor];

    NSDictionary *titleDict = @{NSParagraphStyleAttributeName: paragraphStyle,
                                NSBackgroundColorAttributeName: clearColor,
                                NSForegroundColorAttributeName: blackColor
                                };

    //NSString *titleText = [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:indexPath.row]];
    if (indexPath.row < [self.defaultStrings count]) {
        NSString *titleText = [self.defaultStrings objectAtIndex:indexPath.row];
        if (titleText) {
            NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleText attributes:titleDict];
            cell.textLabel.attributedText = title;
        }
    }


    //cell.textLabel.opaque = YES;
    cell.textLabel.layer.opaque = YES;

    //[cell setNeedsLayout];
    //[cell layoutIfNeeded];
//
//    DLogObject(cell.textLabel);
//
//    DLogBOOL(cell.textLabel.opaque);

    return cell;
}

//- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
//
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
