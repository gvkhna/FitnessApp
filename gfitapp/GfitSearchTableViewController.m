//
//  GfitSearchTableViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/23/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchTableViewController.h"
#import "GfitSearchTableView.h"
#import "GfitSearchTableViewCell.h"
#import "GfitSerialOperationQueue.h"
#import <DAKeyboardControl/DAKeyboardControl.h>

@interface GfitSearchTableViewController () <UILayoutSupport>

@property (nonatomic, strong) GfitSearchTableView *view;
@property (nonatomic, strong) GfitSerialOperationQueue *operationQueue;
@property (nonatomic, assign, getter = isReloading) BOOL reloading;

@end

@implementation GfitSearchTableViewController

#pragma mark - Table view controller setup

- (instancetype)initWithSearchTableViewStyle {
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)loadView {
    [super loadView];
    self.view = [[GfitSearchTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.rowHeight = kGfitSearchTableViewRowHeight;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;

    self.tableView.delegate = self;

//    [self.tableView addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
//
//
//    }];

    [self.tableView registerClass:[GfitSearchTableViewCell class] forCellReuseIdentifier:GfitSearchTableViewCellIdentifier];

    self.operationQueue = [GfitSerialOperationQueue new];
}

- (void)viewWillDisappear:(BOOL)animated {

    [self.tableView removeKeyboardControl];

    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;

    [super viewWillDisappear:animated];
}

//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows]
    //                 withRowAnimation:UITableViewRowAnimationNone];

    [self.tableView reloadData];
    //[self.tableView setNeedsLayout];
    //[self.tableView layoutIfNeeded];
}

//
//- (CGSize)preferredContentSize {
//    return CGRectInset(self.view.bounds, 0, -kGfitSearchTableViewTopMargin).size;
//}

#pragma mark - UILayoutSupport Protocol Methods

/**
 *  Support for UILayoutSupport protocol
 *
 *  @return the length for the topLayoutGuide
 */
- (CGFloat)length {
    return kGfitSearchTableViewTopMargin;
}

/**
 *  View Controller Layout support for topLayoutGuide
 *
 *  @return object implementing protocol
 */
- (id<UILayoutSupport>)topLayoutGuide {
    return self;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= - 65.0f) {
        GfitSearchTableViewController * __weak weakSelf = self;
        NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
        NSBlockOperation * __weak weakOperation = blockOperation;
        [blockOperation addExecutionBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                GfitSearchTableViewController *strongSelf = weakSelf;
                if ([weakOperation isCancelled]) {
                    return;
                }

                if ([strongSelf.searchCancelDelegate respondsToSelector:@selector(searchCancelInteractive:)]) {
                    [strongSelf.searchCancelDelegate performSelector:@selector(searchCancelInteractive:) withObject:nil];
                }
            });
        }];
        [self.operationQueue addOperation:blockOperation];
	}
}



#pragma mark - Table view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    GfitSearchTableViewController * __weak weakSelf = self;
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    NSBlockOperation * __weak weakOperation = blockOperation;
    [blockOperation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakOperation isCancelled]) {
                return;
            }

            [weakSelf.view setShowSeparatorLine:(scrollView.contentOffset.y >= 0.5)];
        });
    }];
    [self.operationQueue addOperation:blockOperation];
}
//
//- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    GfitSearchTableViewCell *scell = (GfitSearchTableViewCell*)cell;
//    if (indexPath.row == 0) {
//        scell.separator = YES;
//        [scell setTopCornersRounded:YES];
//    } else if (indexPath.row == ([tableView numberOfRowsInSection:indexPath.section] -1)) {
//        scell.separator = NO;
//        [scell setBottomCornersRounded:YES];
//    } else {
//        scell.separator = YES;
//        [scell setTopCornersRounded:NO];
//    }
//}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
