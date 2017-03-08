//
//  GfitSerialOperationQueue.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/7/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSerialOperationQueue.h"

@implementation GfitSerialOperationQueue

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxConcurrentOperationCount = 1;
    }
    return self;
}

@end
