//
//  GHealthViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 6/20/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GHealthViewController.h"
#import "GMenuGridController.h"
#import "GHealthMenuGridDelegate.h"
#import "GHealthView.h"

@interface GHealthViewController ()

@property (nonatomic, strong) GHealthView *view;
@property (nonatomic, strong) GMenuGridController *gridController;
@property (nonatomic, strong) GHealthMenuGridDelegate *gridDelegate;

@end

@implementation GHealthViewController

#pragma mark - View Setup Methods

- (void)loadView {
	self.gridDelegate = [[GHealthMenuGridDelegate alloc] initWithNextResponder:self];
	self.gridController = [[GMenuGridController alloc] init];
	self.gridController.dataSource = self.gridDelegate;
	self.gridController.delegate = self.gridDelegate;

	[self addChildViewController:self.gridController];

	self.view = [[GHealthView alloc] initWithGridController:self.gridController];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    self.title = NSLocalizedString(@"Health", nil);
	[self.gridController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];

    self.gridDelegate = nil;
	self.gridController = nil;
}

@end
