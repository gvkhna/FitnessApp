//
//  GfitAppDelegate.m
//  gfitapp
//
//  Created by Gaurav Khanna on 11/23/12.
//  Copyright (c) 2012 Gaurav Khanna. All rights reserved.
//

#import "GfitAppDelegate.h"
#import "GfitHorizontalSlidingTabBarController.h"
#import "GfitHTTPSessionManager.h"
//#import <TestFlightSDK/TestFlight.h>

@interface GfitAppDelegate () <UIApplicationDelegate>

@property (nonatomic, readwrite) UIWindow *window;


@end

@implementation GfitAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    @autoreleasepool {

        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            //UISplitViewController *splitViewController = [[UISplitViewController alloc] initWithNibName:nil bundle:nil];
        } else {
            self.window.rootViewController = [[GfitHorizontalSlidingTabBarController alloc] initWithNibName:nil bundle:nil];
        }

        [self.window makeKeyAndVisible];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
           // [TestFlight takeOff:@"8769c2eb-b725-44f0-9875-316265d4ca2d"];
        });

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [[GfitHTTPSessionManager sharedClient] checkForUpdates];
        });
        
        return YES;

    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

//
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//
//
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application
//{
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)preferredContentSizeChanged:(NSNotification*)notif {
//    [self.window.rootViewController.view setNeedsLayout];
//    [self.window.rootViewController.view layoutIfNeeded];
//}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    DLogFunctionLine();

    [self.window setNeedsLayout];
    [self.window layoutIfNeeded];
}

@end
