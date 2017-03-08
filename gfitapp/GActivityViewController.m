//
//  GActivityViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 3/24/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GActivityViewController.h"

@implementation GActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];


    [self setNeedsStatusBarAppearanceUpdate];
}

//- (void)viewDidAppear:(BOOL)animated {
////    [UIView animateWithDuration:1.0 animations:^{
////        self.preferredStatusBarStyle =
////    }completion:<#^(BOOL finished)completion#>]
//    [self setNeedsStatusBarAppearanceUpdate];
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
