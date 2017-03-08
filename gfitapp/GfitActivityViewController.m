//
//  GfitActivityViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/3/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitActivityViewController.h"
#import "GfitMenuGridController.h"
#import "GfitMenuGridControllerDataSource.h"

@interface GfitActivityViewController () <GfitMenuGridControllerDataSource, GfitMenuGridControllerDelegate>

@property (nonatomic, strong) GfitMenuGridController *menuGridController;

@end

@implementation GfitActivityViewController

- (instancetype)initWithDefaultRootNavigationEvent {
    self = [super initWithNibName:nil bundle:nil];
    return self;
}

- (NSString*)title {
    return NSLocalizedString(@"Activity", nil);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	// Do any additional setup after loading the view.

    self.menuGridController = [[GfitMenuGridController alloc] initWithDataSource:self];
    [self.view addSubview:self.menuGridController.collectionView];
    [self addChildViewController:self.menuGridController];
    self.menuGridController.delegate = self;
    //    self.menuGridController.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    //self.menuGridController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.menuGridController didMoveToParentViewController:self];

    //[self.view setNeedsUpdateConstraints];
}

- (void)viewWillDisappear:(BOOL)animated {

    self.menuGridController.delegate = nil;
    self.menuGridController.dataSource = nil;


    [super viewWillDisappear:animated];

    //self.menuGridController.collectionView.delegate = nil;
    //[self.menuGridController.collectionView removeFromSuperview];
//    self.menuGridController.delegate = nil;
//    [self.menuGridController willMoveToParentViewController:nil];
//    [self.menuGridController removeFromParentViewController];
//    [self.menuGridController didMoveToParentViewController:nil];
    //self.menuGridController = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    //self.menuGridController.delegate = nil;
}

//
//- (void)updateViewConstraints {
//    [super updateViewConstraints];
//
//    [self.view removeConstraints:self.view.constraints];
//
//    //[self.menuGridController
//
//    UIView *view = self.menuGridController.collectionView;
//
//    NSDictionary *dict = NSDictionaryOfVariableBindings(view);
//
//    NSArray *hconstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(>=50)]|" options:0 metrics:0 views:dict];
//
//    NSArray *constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-150-[view(>=50,<=)]|" options:0 metrics:0 views:dict];
//
//    [self.view addConstraints:constraint];
//    [self.view addConstraints:hconstraint];
//
//    //    UIView *view = self.menuGridController.collectionView;
//    //    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(view);
//    //
//    //    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[view(>=200)]-|"
//    //                                                                   options:0
//    //                                                                   metrics:nil
//    //                                                                     views:viewsDictionary];
//    //
//    //    //NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-337-[view(>=200)]-|"
//    ////                                                                    options:0
//    ////                                                                    metrics:nil
//    ////                                                                      views:viewsDictionary];
//    //
//    //
//    //    NSLayoutConstraint *vCenter = [NSLayoutConstraint constraintWithItem:self.menuGridController.collectionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
//    //    [self.view addConstraints:constraints];
//    //    [self.view addConstraint:vCenter];
//    //[self.view addConstraints:constraints2];
//}

//- (void)updateViewConstraints
//{
//    [super updateViewConstraints];
//
//    NSDictionary *views = @{ @"button" : self.button };
//
//    // Position the button with edge padding
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[button]-20-|" options:0 metrics:nil views:views]];
//
//    // Vertically center.
//    NSLayoutConstraint *verticallyCenteredConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
//    [self.view addConstraint:verticallyCenteredConstraint];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Menu Grid Methods

- (void)gridControllerWillDisplayCell:(id<GfitMenuGridCellContent>)cell atIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case GfitMenuGridControllerCellPositionTopLeft:
			cell.title = NSLocalizedString(@"ADD", nil);
			cell.image = [UIImage imageNamed:@"menu_grid_add_icon"];
			break;

		case GfitMenuGridControllerCellPositionTopRight:
			cell.title = NSLocalizedString(@"INFO", nil);
			cell.image = [UIImage imageNamed:@"menu_grid_info_icon"];
			break;

		case GfitMenuGridControllerCellPositionBottomLeft:
			cell.title = NSLocalizedString(@"ACTIVITY", nil);
			cell.image = [UIImage imageNamed:@"menu_grid_activity_icon"];
			break;

		case GfitMenuGridControllerCellPositionBottomRight:
			cell.title = NSLocalizedString(@"MORE", nil);
			cell.image = [UIImage imageNamed:@"menu_grid_more_icon"];
			break;
	}
}

- (void)gridControllerDidSelectItemAtIndexPath:(NSIndexPath*)indexPath {
    Class controllerClass;
    switch (indexPath.row) {
        case GfitMenuGridControllerCellPositionTopLeft:
            controllerClass = [UIViewController class];
            break;
        case GfitMenuGridControllerCellPositionTopRight:
            controllerClass = [UIViewController class];
            break;
        case GfitMenuGridControllerCellPositionBottomLeft:
            controllerClass = [UIViewController class];
            break;
        case GfitMenuGridControllerCellPositionBottomRight:
            controllerClass = [UIViewController class];
            break;
    }

    //    // send a RootNavigationEvent event at nil to send up responder chain to nav controller
    //    UIViewController *controller = [[controllerClass alloc] initWithNibName:nil bundle:nil];
    //
    //    GRootNavigationEvent *event = [[GRootNavigationEvent alloc] init];
    //    event.viewController = controller;
    //    BOOL handled = [[UIApplication sharedApplication] sendAction:@selector(frontViewController:forEvent:) to:nil from:self forEvent:event];
    //
    //    NSAssert(handled, @"gridControllerDidSelectItemAtIndexPath:%@ handled:%i", indexPath, handled);
}

@end
