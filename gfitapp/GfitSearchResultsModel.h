//
//  GfitSearchResultsModel.h
//  gfitapp
//
//  Created by Gaurav Khanna on 4/22/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GfitSearchResultsModelProtocol <NSObject>

- (void)loadedResults;

@end

@interface GfitSearchResultsModel : NSObject <UITableViewDataSource>

@property (nonatomic, weak) id delegate;

+ (NSURLSessionDataTask *)globalSearchResultsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
