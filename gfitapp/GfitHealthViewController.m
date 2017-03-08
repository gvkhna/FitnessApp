//
//  GfitHealthViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 1/1/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitHealthViewController.h"
#import "GfitMenuGridController.h"
#import "GfitHealthView.h"

@interface GfitHealthViewController () <GfitMenuGridControllerDataSource>

@property (nonatomic, strong) GfitHealthView *view;
@property (nonatomic, strong) GfitMenuGridController *menuGridController;

@end

@implementation GfitHealthViewController

- (void)loadView {
    self.view = [[GfitHealthView alloc] initWithFrame:CGRectZero];
}

- (id)title {
    return NSLocalizedString(@"Health", nil);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    @autoreleasepool {
        self.automaticallyAdjustsScrollViewInsets = NO;

        self.view.backgroundColor = [UIColor whiteColor];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        UIImage *image = [UIImage imageNamed:@"main_menu_bg"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        //[self.view addSubview:imageView];

        self.menuGridController = [[GfitMenuGridController alloc] initWithDataSource:self];
        [self addChildViewController:self.menuGridController];
        self.view.menuGridController = self.menuGridController;
        [self.view didSetMenuGridController];
        [self.menuGridController didMoveToParentViewController:self];
    }
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

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
