//
//  BlueViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/9/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
}

- (CGSize)preferredContentSize {
    return self.navigationController.view.bounds.size;
}

@end
