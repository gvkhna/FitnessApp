//
//  GExerciseView.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/8/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GExerciseView.h"

@interface GExerciseView ()

@property (nonatomic, strong) UIImageView *exerciseImageView;

@end

@implementation GExerciseView

#pragma mark - View Setup Methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createExerciseImageView];
    }
    return self;
}

- (void)createExerciseImageView {
    self.exerciseImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.exerciseImageView];
}

#pragma mark - View Layout Methods

- (void)layoutSubviews {
    [super layoutSubviews];

    
}

@end
