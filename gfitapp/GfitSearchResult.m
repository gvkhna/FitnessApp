//
//  GfitSearchResult.m
//  gfitapp
//
//  Created by Gaurav Khanna on 4/18/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitSearchResult.h"
#import "GfitHTTPSessionManager.h"

@implementation GfitSearchResult

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    //self.resultID = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
    self.searchName = [attributes valueForKeyPath:@"name"];
    self.searchNameAssets = [attributes valueForKeyPath:@"assets"];

    //self.user = [[User alloc] initWithAttributes:[attributes valueForKeyPath:@"user"]];

    return self;
}

#pragma mark -

@end