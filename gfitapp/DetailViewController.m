//
//  DetailViewController.m
//  CorePlotGallery
//
//  Created by Jeff Buck on 8/28/10.
//  Copyright Jeff Buck 2010. All rights reserved.
//

#import "DetailViewController.h"
#import <CorePlot/CorePlot-CocoaTouch.h>
#import "PlotItem.h"
#import "RealTimePlot.h"

@implementation DetailViewController

#pragma mark -
#pragma mark Initialization and Memory Management

- (void)viewDidLoad {
    [super viewDidLoad];

    self.hostingView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.hostingView];
    self.detailItem = [[RealTimePlot alloc] init];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.hostingView = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.hostingView.frame = self.view.bounds;
    [self.detailItem renderInView:self.hostingView withTheme:[self currentTheme] animated:YES];
}

//#pragma mark -
//#pragma mark Split view support
//
//-(void)splitViewController:(UISplitViewController *)svc
//    willHideViewController:(UIViewController *)aViewController
//         withBarButtonItem:(UIBarButtonItem *)barButtonItem
//      forPopoverController:(UIPopoverController *)pc
//{
//    barButtonItem.title = @"Plot Gallery";
//    NSMutableArray *items = [[toolbar items] mutableCopy];
//    [items insertObject:barButtonItem atIndex:0];
//    [toolbar setItems:items animated:YES];
//    [items release];
//    self.popoverController = pc;
//}
//
//-(void)   splitViewController:(UISplitViewController *)svc
//       willShowViewController:(UIViewController *)aViewController
//    invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    NSMutableArray *items = [[toolbar items] mutableCopy];
//
//    [items removeObjectAtIndex:0];
//    [toolbar setItems:items animated:YES];
//    [items release];
//    self.popoverController = nil;
//}

//#pragma mark -
//#pragma mark Rotation support
//
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return YES;
//}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    if ( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ) {
//        self.hostingView.frame = self.view.bounds;
//    }
//    [detailItem renderInView:self.hostingView withTheme:[self currentTheme] animated:YES];
//}

#pragma mark -
#pragma mark Theme Selection

-(CPTTheme *)currentTheme {
    return [CPTTheme themeNamed:kCPTPlainWhiteTheme];
}


@end
