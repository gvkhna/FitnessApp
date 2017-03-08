//
//  GfitContentNavigationController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 2/9/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitContentNavigationController.h"
#import "GfitSerialOperationQueue.h"
#import "GfitContentNavigationView.h"
#import "GfitContentFakeNavigationDelegate.h"
#import "GfitContentNavigationBar.h"
#import "UIView+RecursiveLayout.h"

@interface UINavigationController () <UINavigationBarDelegate, GfitContentNavigationBarDelegateProtocol>

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item;

@end

@interface GfitContentNavigationController () 

@property (nonatomic, strong) GfitSerialOperationQueue *operationQueue;
@property (nonatomic, assign) CGFloat originalNavigationBarZPosition;
@property (nonatomic, strong) UINavigationBar *fakeNavigationBar;
@property (nonatomic, strong) GfitContentFakeNavigationDelegate *fakeNavigationBarDelegate;
//@property (nonatomic, strong) GfitContentNavigationView *view;
//@property (nonatomic, strong) GfitContentNavigationBar *navigationBar;

@end

@implementation GfitContentNavigationController

//- (void)loadView {
//    [super loadView];
//    self.view = [[GfitContentNavigationView alloc] initWithFrame:_view.bounds];
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//}

- (void)viewDidLayoutSubviews {
    //self.fakeNavigationBar.frame = self.navigationBar.frame;

    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {

    if ([self.navigationBar respondsToSelector:@selector(setMainMenuNavigationDelegate:)]) {
        [self.navigationBar performSelector:@selector(setMainMenuNavigationDelegate:) withObject:self];
    }

//    if ([self.navigationBar respondsToSelector:@selector(tryToPush)]) {
//        [self.navigationBar performSelector:@selector(tryToPush)];
//    }

    [self.navigationBar setNeedsLayoutRecursively];

//    [self.navigationBar setNeedsLayout];
//    [self.navigationBar layoutIfNeeded];
    [self.navigationBar setNeedsDisplay];

    //self.navigationBar.barTintColor = [[[self.navigationBar class] appearance] barTintColor];
//    [self.navigationBar tintColorDidChange];
//
//    if ([self.navigationBar respondsToSelector:@selector(touchesBegan:withEvent:)]) {
//        [self.navigationBar performSelector:@selector(touchesBegan:withEvent:) withObject:nil withObject:nil];
//    }
//
//    if ([self.navigationBar respondsToSelector:@selector(touchesEnded:withEvent:)]) {
//        [self.navigationBar performSelector:@selector(touchesEnded:withEvent:) withObject:nil withObject:nil];
//    }
//
//    if ([[self.navigationBar items] count] == 2) {
//        self.navigationBar.layer.zPosition = -100;
//        //UINavigationItem *fakeTopNavigationItem = [[UINavigationItem alloc] initWithTitle:self.topViewController.title];
//        //UINavigationItem *fakeBackNavigationItem = [[UINavigationItem alloc] initWithTitle:[self.viewControllers[0] title]];
//
//
//
//    }

        [super viewWillAppear:animated];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    if (![self.navigationController.viewControllers containsObject:self]) {
//        [self newOperationBackToMainMenu];
//    }
//    [super viewWillDisappear:animated];
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if ([[self.navigationBar items] count] == 2) {
        //self.navigationBar.layer.zPosition = -100;

        //self.fakeNavigationBar = [[UINavigationBar alloc] initWithFrame:self.navigationBar.frame];
        //self.fakeNavigationBar.barPosition = self.navigationBar.barPosition;
        //[self.fakeNavigationBar setBackgroundImage:[self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];

        //self.fakeNavigationBar = [self.navigationBar;
        //self.fakeNavigationBarDelegate = [[GfitContentFakeNavigationDelegate alloc] init];
        //self.fakeNavigationBar.delegate = self.fakeNavigationBarDelegate;
        //self.fakeNavigationBar.bounds = self.navigationBar.bounds;
        //self.fakeNavigationBar.tintColor = self.navigationBar.tintColor;
        //self.fakeNavigationBar.barTintColor = self.navigationBar.barTintColor;
        //[self.fakeNavigationBar setItems:[self.navigationBar items]];
        //[self.fakeNavigationBar setItems:@[fakeBackNavigationItem, fakeTopNavigationItem]];
        //[self.fakeNavigationBar]
        //self.view.fakeNavigationBar = self.fakeNavigationBar;
        //self.view.realNavigationBar = self.navigationBar;
        //[self.view addSubview:self.fakeNavigationBar];
    }

    self.operationQueue = [[GfitSerialOperationQueue alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;
}

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
//    return [super navigationBar:navigationBar shouldPushItem:item];
//    if ([[navigationBar items] count] > 2) {
//        self.fakeNavigationBar.hidden = YES;
//        //self.navigationBar.layer.zPosition = self.originalNavigationBarZPosition;
//    } else {
//        self.fakeNavigationBar.hidden = NO;
//        //self.navigationBar.layer.zPosition = -100;
//    }
//    return YES;
//}

//- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
//    if ([[navigationBar items] count] > 2) {
//        self.fakeNavigationBar.hidden = YES;
//        self.navigationBar.layer.zPosition = self.originalNavigationBarZPosition;
//    } else {
//        self.fakeNavigationBar.hidden = NO;
//        self.navigationBar.layer.zPosition = -100;
//    }
//}

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
//    BOOL ret = [super navigationBar:navigationBar shouldPushItem:item];
//    if (ret) {
//        self.fakeNavigationBar.hidden = YES;
//        self.navigationBar.layer.zPosition = self.originalNavigationBarZPosition;
//    }
//    return ret;
//}

- (void)navigationBarBackToMainMenu:(id)sender {
    [self newOperationBackToMainMenu];
}

- (void)newOperationBackToMainMenu {
    NSBlockOperation *operation = [NSBlockOperation new];
    @weakify(operation);
    @weakify(self);
    [operation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{

            if ([operation_weak_ isCancelled]) {
                return;
            }

            @strongify(self);
            [self.contentNavigationDelegate backToMainMenu:self];
        });
    }];
    [self.operationQueue addOperation:operation];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    DLogFunctionLine();
    @autoreleasepool {
        // here we can detect that it's a back press and forward to the GRootNavigationController
        //[[UIApplication sharedApplication] sendAction:@selector(back:) to:nil from:self forEvent:[UIEvent new]];

        if ([[navigationBar items] count] > 2) {
            return [super navigationBar:navigationBar shouldPopItem:item];
            //return YES;
        }

        DLogFunctionLine();

        NSAssert([self.contentNavigationDelegate respondsToSelector:@selector(backToMainMenu:)], @"GfitNavigationViewControllerDelegate:%@ object must respond to backButton event", self.contentNavigationDelegate);

        NSAssert([self.contentNavigationDelegate conformsToProtocol:@protocol(GfitContentNavigationViewControllerDelegateProtocol)], @"GfitNavigationViewControllerDelegate:%@ must implement all required methods of protocol", self.contentNavigationDelegate);

        //[self newOperationBackToMainMenu];

        self.originalNavigationBarZPosition = self.navigationBar.layer.zPosition;

        self.navigationBar.layer.zPosition = -100;

        //DLogObject(self.navigationBar.items);

        //self.navigationBar.layer.hidden = YES;
        //[UIView setAnimationsEnabled:NO];
        //
        //        UIView *pressedBackView = [self.navigationBar _g_findBackIndicatorView];
        //        UIView *pressedTextView = [self.navigationBar _g_findBackTextView:self.navigationViewControllerDelegate.title];
        //
        //        // to preserve the back button pressed state we're gonna do some serious black magic
        //        self.backButtonSnapshotView = [pressedBackView snapshotViewAfterScreenUpdates:NO];
        //        self.labelSnapshotView = [pressedTextView snapshotViewAfterScreenUpdates:NO];

        // the navigation item is going to be updated animated or otherwise
        // it'll cause a jump in the animation immietly when the animation starts
        // we're returning yes so that the navigationItem is popped now, that's fine
        // we'll push back later
        // right now we need to display the snapshot view (essentially turning off draw updates)
        // until we're ready to animate in `GfitRootViewController` animateTransition:
        //self.snapshotView = [self.view snapshotViewAfterScreenUpdates:NO];
        //[self.view addSubview:self.snapshotView];
        //DLogUIView(self.navigationBar);

        
        return YES;
    }
}

@end
