//
//  GfitContentNavigationController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 2/9/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GfitContentNavigationViewControllerDelegateProtocol <NSObject>
@required
//- (NSString*)title;

// back button on root stack
- (void)backToMainMenu:(id)sender;

@end

@interface GfitContentNavigationController : UINavigationController

@property (nonatomic, strong) UIView *snapshotView;
@property (nonatomic, assign, readonly) CGFloat originalNavigationBarZPosition;
@property (nonatomic, weak) id <GfitContentNavigationViewControllerDelegateProtocol> contentNavigationDelegate;

@end
