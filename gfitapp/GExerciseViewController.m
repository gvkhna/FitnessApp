//
//  GExerciseViewController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 9/2/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GExerciseViewController.h"
#import "GExerciseView.h"
#import "GMenuGridController.h"

@interface GExerciseViewController () <GMenuGridControllerDataSource>

@property (nonatomic, strong) GExerciseView *view;

@end

@implementation GExerciseViewController

- (void)loadView {
    self.view = [[GExerciseView alloc] initWithFrame:CGRectZero];
}

@end
