//
//  GfitHTTPSessionManager.h
//  gfitapp
//
//  Created by Gaurav Khanna on 10/10/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

extern NSString * const GfitHTTPSessionManagerHostname;
extern NSString * const GfitHTTPSessionManagerTimestampDeviceDefault;
extern NSString * const GfitHTTPSessionManagerTimestampDeviceFile;
extern NSString * const GfitHTTPSessionManagerTimestampUpdateFile;
extern NSString * const GfitHTTPSessionManagerManifestFile;
extern NSString * const GfitHTTPSessionManagerManifestDeviceFile;
extern NSString * const GfitHTTPSessionManagerCorpusFile;
extern NSString * const GfitHTTPSessionManagerCorpusDeviceFile;

@interface GfitHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, assign, getter = shouldUpdate) BOOL update;

+ (instancetype)sharedClient;

/**
 *  Initialization function to start monitoring reachability
 */
- (void)checkForUpdates;

@end
