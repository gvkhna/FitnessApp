//
//  GreenViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 9/24/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GreenViewController.h"

@interface GreenViewController ()

@end

@implementation GreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

- (CGSize)preferredContentSize {
    return self.navigationController.view.bounds.size;
}

@end
