//
//  GfitSearchResultsModel.m
//  gfitapp
//
//  Created by Gaurav Khanna on 4/22/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchResultsModel.h"
#import "GfitSearchResult.h"
#import "GfitHTTPSessionManager.h"
#import "GfitSearchTableViewCell.h"
#import "GfitSearchTableViewController.h"

@interface GfitSearchResultsModel ()

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation GfitSearchResultsModel

+ (NSURLSessionDataTask *)globalSearchResultsWithBlock:(void (^)(NSArray *results, NSError *error))block {
    return [[GfitHTTPSessionManager sharedClient] GET:GfitHTTPSessionManagerManifestFile parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *resultsFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutableResults = [NSMutableArray arrayWithCapacity:[resultsFromResponse count]];
        for (NSDictionary *attributes in resultsFromResponse) {
            GfitSearchResult *result = [[GfitSearchResult alloc] initWithAttributes:attributes];
            [mutableResults addObject:result];
        }

        if (block) {
            block([NSArray arrayWithArray:mutableResults], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

#pragma mark - UITableView Data Source methods

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionTask *task = [GfitSearchResultsModel globalSearchResultsWithBlock:^(NSArray *results, NSError *error) {
            if (!error) {
                self.searchResults = results;
                //[self.searchTableViewController.tableView reloadData];
            }
        }];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
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
//    if (indexPath.row < [self.defaultStrings count]) {
//        NSString *titleText = [self.defaultStrings objectAtIndex:indexPath.row];
//        if (titleText) {
//            NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleText attributes:titleDict];
//            cell.textLabel.attributedText = title;
//        }
//    }

    if (indexPath.row < [self.searchResults count]) {
        NSString *titleText = [self.searchResults objectAtIndex:indexPath.row];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleText attributes:titleDict];
        cell.textLabel.attributedText = title;
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

@end
