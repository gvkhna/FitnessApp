//
//  GfitHTTPSessionManager.m
//  gfitapp
//
//  Created by Gaurav Khanna on 10/10/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitHTTPSessionManager.h"
#import <AFNetworking/AFNetworking.h>

NSString * const GfitHTTPSessionManagerHostname = @"http://gfitappcms.gfitapp.com/";
NSString * const GfitHTTPSessionManagerTimestampDeviceDefault = @"timestamp-device";
NSString * const GfitHTTPSessionManagerTimestampUpdateFile = @"timestamp.json";
//NSString * const GfitHTTPSessionManagerManifestDeviceFile = @"manifest-device.json";
NSString * const GfitHTTPSessionManagerManifestFile = @"manifest.json";
//NSString * const GfitHTTPSessionManagerCorpusDeviceFile = @"corpus-device.json";
NSString * const GfitHTTPSessionManagerCorpusFile = @"corpus.json";

@interface GfitHTTPSessionManager ()

//@property (nonatomic, strong) AFHTTPSessionManager *reachabilityManager;

@end

@implementation GfitHTTPSessionManager

+ (instancetype)sharedClient {
    static GfitHTTPSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GfitHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:GfitHTTPSessionManagerHostname]];
        //_sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    });

    return _sharedClient;
}

- (NSURL *)appCachesDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSTimeInterval)currentTimestamp {
    return [[NSDate date] timeIntervalSinceDate:[[NSUserDefaults standardUserDefaults] objectForKey:GfitHTTPSessionManagerTimestampDeviceDefault]];
}

- (void)checkDeviceTimestamp {
    // calculate initial values
    NSTimeInterval sixtyMinutes = 60 * 60;
    NSTimeInterval priorTimestamp = [[NSDate date] timeIntervalSince1970] - sixtyMinutes;

    NSTimeInterval currentTimestamp = [[NSDate date] timeIntervalSinceDate:[[NSUserDefaults standardUserDefaults] objectForKey:GfitHTTPSessionManagerTimestampDeviceDefault]];

//    // read current device timestamp
//    NSError *readError;
//    NSString *deviceTimestampPath = [self.appCachesDirectory.path stringByAppendingPathComponent:GfitHTTPSessionManagerTimestampDeviceFile];
//    NSString *timestampString = [NSString stringWithContentsOfFile:deviceTimestampPath encoding:NSUTF8StringEncoding error:&readError];
//
//    if (readError) {
//        // handle error
//        return YES;
//    }



    //NSError *jsonError;
    //id data = [NSJSONSerialization dataWithJSONObject:timestampString options:NULL error:&jsonError];
    //if (jsonError) {
        // handle error
        //    return YES;
        //}
    // handle read the object error
//    NSDictionary *timestampDict;
//    NSNumber *timestampValue;
//    if ([data isKindOfClass:[NSDictionary class]]) {
//        timestampDict = [data objectForKey:@"data"];
//        if ([timestampDict isKindOfClass:[NSDictionary class]]) {
//            timestampValue = [timestampDict objectForKey:@"timestamp"];
//        }
//    }

    // compare values, return YES if need a remote check
    //NSTimeInterval currentTimestamp = [NSNumber number];
    //return priorTimestamp > currentTimestamp;
}

/**
 *  Sets the local TimestampDeviceFile to the current timestamp in time
 */
- (void)saveCurrentDeviceTimestamp {
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"timestamp-device"];
    //[NSDate date]
//    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
//    NSNumber *timestampValue = [NSNumber numberWithDouble:timestamp];
//    NSDictionary *timestampDict = @{@"data": @{@"timestamp": timestampValue}};
//
//    NSError *jsonError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:timestampDict options:NULL error:&jsonError];
//
//    if (jsonData != nil) {
//        NSString *timestampPath = [self.appCachesDirectory.path stringByAppendingPathComponent:GfitHTTPSessionManagerTimestampDeviceFile];
//        BOOL status = [jsonData writeToFile:timestampPath atomically:YES];
//
//        if (!status) {
//            NSLog(@"Oh no!");
//        }
//    } else {
//        NSLog(@"My JSON wasn't valid: %@", jsonError);
//    }
}

/**
 *  Fetches the remote TimestampUpdateFile to see if updating the resources is necessary
 *
 *  @todo YES if updating the resources is necessary
 */
- (void)checkRemoteTimestamp {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *timestampURL = [GfitHTTPSessionManagerHostname stringByAppendingString:GfitHTTPSessionManagerTimestampUpdateFile];
//    [manager GET:timestampURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSError *jsonError;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NULL error:&jsonError];
//        if (jsonData != nil) {
//            NSString *timestampPath = [self.appCachesDirectory.path stringByAppendingPathComponent:GfitHTTPSessionManagerTimestampUpdateFile];
//            BOOL status = [jsonData writeToFile:timestampPath atomically:YES];
//            if (!status) {
//                NSLog(@" error in status: %i", status);
//                //return YES;
//            }
//        }
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}

- (void)updateResources {
//    NSString *key = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
//    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/", key]];
//
//    // Initialize Request Operation Manager
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//
//    // Configure Request Operation Manager
//    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
//
//    // Send Request
//    [manager GET:@"37.8267,-122.423" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // Process Response Object
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        // Handle Error
//    }];
}

- (void)checkForUpdates {
    //GfitHTTPSessionManager * __weak weakSelf = self;

        NSLog(@"checking for updates...");
//        //if ([weakSelf checkDeviceTimestamp]) {
//            NSLog(@"device checking for updates confirmed.");
//        //[weakSelf saveCurrentDeviceTimestamp];
//            NSLog(@"saved current device timestamp");

        [[GfitHTTPSessionManager sharedClient] GET:GfitHTTPSessionManagerTimestampUpdateFile parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {


            NSDictionary *timestampDict;
            NSTimeInterval timestampValue;
            if ([JSON isKindOfClass:[NSDictionary class]]) {
                timestampDict = [JSON objectForKey:@"data"];
                if ([timestampDict isKindOfClass:[NSDictionary class]]) {
                    timestampValue = [[timestampDict valueForKeyPath:@"timestamp"] doubleValue];
                    if (timestampValue > [self currentTimestamp]) {
                        NSLog(@" needs to update");
                    }
                }
            }

            //NSTimeInterval remoteTimestamp = [[JSON valueForKey:@"data"] doubleForKey:@"timestamp"];
            //if (remoteTimestamp >
            //NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
//                for (NSDictionary *attributes in postsFromResponse) {
//                    //Post *post = [[Post alloc] initWithAttributes:attributes];
//                    //[mutablePosts addObject:post];
//                }

//                if (block) {
//                    block([NSArray arrayWithArray:mutablePosts], nil);
//                }
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//                if (block) {
//                    block([NSArray array], error);
//                }
//DLogObject(error);
            //DLogObject(task);
        }];

        //}

//        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager managerForDomain:GfitHTTPSessionManagerHostname];
//
//        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            NSLog(@"REACHABLE!");
//            //if ([weakSelf checkDeviceTimestamp]) {
//            //[weakSelf updateDeviceTimestamp];
//            //if ([weakSelf checkRemoteTimestamp]) {
//            //      [weakSelf updateResources];
//            //  }
//            //}
//
//        }];
//
//        [manager startMonitoring];
//        
//        weakSelf.reachabilityManager = manager;
//});
}

@end
