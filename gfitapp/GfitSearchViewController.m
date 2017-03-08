//
//  GfitSearchViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/31/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchViewController.h"
#import "GfitSearchTableViewController.h"
#import "GfitSerialOperationQueue.h"
#import "GfitSearchView.h"
#import "GfitSearchTableViewControllerCancelGestureProtocol.h"
#import "GfitSearchResult.h"
#import "GfitSearchResultsModel.h"

@interface GfitSearchViewController () <GfitSearchTableViewControllerCancelGestureProtocol, GfitSearchResultsModelProtocol>

@property (nonatomic, strong) GfitSearchView *view;
@property (nonatomic, strong) GfitSearchTableViewController *searchTableViewController;
@property (nonatomic, strong) GfitSerialOperationQueue *operationQueue;
@property (nonatomic, strong) GfitSearchResultsModel *searchResultsModel;

@end

@implementation GfitSearchViewController

- (void)loadView {
    self.view = [[GfitSearchView alloc] initWithFrame:CGRectZero];
}

- (CGSize)preferredContentSize {
	return self.view.bounds.size;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (NSString *)title {
	return [[NSBundle mainBundle] localizedStringForKey:@"Search" value:nil table:@"LocalizableStartup"];
}

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;

    //[UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    //[self.refreshControl setRefreshingWithStateOfTask:task];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view

    self.searchResultsModel = [[GfitSearchResultsModel alloc] init];

    self.view.searchTextFieldView.searchField.delegate = self;

    self.searchTableViewController = [[GfitSearchTableViewController alloc] initWithSearchTableViewStyle];
    [self addChildViewController:self.searchTableViewController];
    self.view.searchTableViewController = self.searchTableViewController;
    self.searchTableViewController.searchCancelDelegate = self;
    [self.view didSetSearchTableViewController];
    self.searchTableViewController.tableView.dataSource = self.searchResultsModel;
    //[self.searchTableViewController.tableView reloadData];
    [self.searchTableViewController didMoveToParentViewController:self];
}



//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    self.operationQueue = [[GfitSerialOperationQueue alloc] init];
//
//    // update search field editing and keyboard visible
//    GfitSearchViewController * __weak weakSelf = self;
//    [self.operationQueue addOperationWithBlock:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //GfitSearchViewController *strongSelf = weakSelf;
//
//            UITextField *searchField = weakSelf.view.searchTextFieldView.searchField;
//            //weakSelf.view.searchTextFieldView.searchCancelButton;
//            DLogObject(searchField);
//
//            if ([searchField canBecomeFirstResponder]) {
//                DLogFunctionLine();
//                [searchField becomeFirstResponder];
//            }
//
//            //        if (strongSelf.searching && [searchField canBecomeFirstResponder]) {
//            //            DLogFunctionLine();
//            //            [searchField becomeFirstResponder];
//            //        } else if (!strongSelf.searching && [searchField canResignFirstResponder]) {
//            //            DLogFunctionLine();
//            //            [searchField resignFirstResponder];
//            //        }
//        });
//    }];
//
//}

- (void)loadedResults {
    [self.searchTableViewController.tableView reloadData];
}

- (void)searchFieldBecomeFirstResponder {
    UITextField *searchField = self.view.searchTextFieldView.searchField;

    //[searchField becomeFirstResponder];
    if ([searchField canBecomeFirstResponder]) {
        DLogFunctionLine();
        [searchField becomeFirstResponder];
    }
}

- (void)searchFieldResignFirstResponder {
    //UITextField *searchField = self.view.searchTextFieldView.searchField;

    [self.view endEditing:YES];
    //[self.view.searchTextFieldView performSelector:@selector(setSearchField:) withObject:nil];
    //searchField.userInteractionEnabled = NO;
    //NSParameterAssert(searchField != nil);
    //DLogObject(searchField);
    //[searchField resignFirstResponder];
    //self.view.searchTextFieldView.searchField = nil;

    //if ([searchField canResignFirstResponder]) {
    //    DLogFunctionLine();
    // [searchField resignFirstResponder];
    //}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //GfitSearchViewController * __weak weakSelf = self;

    self.operationQueue = [[GfitSerialOperationQueue alloc] init];

    // update search field editing and keyboard visible
    GfitSearchViewController * __weak weakSelf = self;
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    NSBlockOperation * __weak weakOperation = blockOperation;
    [blockOperation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //GfitSearchViewController *strongSelf = weakSelf;

            if ([weakOperation isCancelled]) {
                return;
            }

            [weakSelf searchFieldBecomeFirstResponder];

    //        if (strongSelf.searching && [searchField canBecomeFirstResponder]) {
    //            DLogFunctionLine();
    //            [searchField becomeFirstResponder];
    //        } else if (!strongSelf.searching && [searchField canResignFirstResponder]) {
    //            DLogFunctionLine();
    //            [searchField resignFirstResponder];
    //        }
        });
    }];
    [self.operationQueue addOperation:blockOperation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //self.searchTableViewController.tableView.dataSource = nil;
    //self.searchResultsModel = nil;

    //[self searchFieldResignFirstResponder];

    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - View actions

- (void)mainMenu:(id)sender {
    NSParameterAssert(self.delegate != nil);
    self.navigationController.transitioningDelegate = self.delegate;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)searchCancelInteractive:(id)sender {
    [self searchCancel:nil];
}

- (void)searchCancel:(id)sender {
    GfitSearchViewController * __weak weakSelf = self;
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    NSBlockOperation * __weak weakOperation = blockOperation;
    [blockOperation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            GfitSearchViewController *strongSelf = weakSelf;

            if ([[strongSelf.navigationController viewControllers] count] < 2) {
                return;
            }

            if ([weakOperation isCancelled]) {
                return;
            }

            [strongSelf searchFieldResignFirstResponder];
            NSParameterAssert(strongSelf.delegate != nil);
            //strongSelf.navigationController.transitioningDelegate = strongSelf.delegate;
            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
        });
    }];
    [self.operationQueue addOperation:blockOperation];
}

@end
