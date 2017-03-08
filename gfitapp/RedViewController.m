//
//  RedViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 9/24/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "RedViewController.h"

@implementation RedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (CGSize)preferredContentSize {
    return self.navigationController.view.bounds.size;
}

@end
