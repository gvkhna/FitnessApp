//
//  GfitMainMenuNavigationController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/9/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitMainMenuNavigationController.h"

@interface GfitMainMenuNavigationController ()

@end

@implementation GfitMainMenuNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//willRotateToInterfaceOrientation:duration:
//willAnimateRotationToInterfaceOrientation:duration:
//didRotateFromInterfaceOrientation:

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    self.view.frame = [[UIScreen mainScreen] bounds];
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    self.view.frame = [[UIScreen mainScreen] bounds];
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    self.view.frame = [[UIScreen mainScreen] bounds];
//    DLogCGRect(self.view.frame);
//}

@end
