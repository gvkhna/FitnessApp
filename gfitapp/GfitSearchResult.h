//
//  GfitSearchResult.h
//  gfitapp
//
//  Created by Gaurav Khanna on 4/18/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GfitSearchResult : NSObject

//@property (nonatomic, assign) NSUInteger postID;
@property (nonatomic, strong) NSString *searchName;
@property (nonatomic, strong) NSArray *searchNameAssets;

//@property (nonatomic, strong) User *user;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
