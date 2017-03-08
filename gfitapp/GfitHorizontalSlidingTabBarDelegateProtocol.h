//
//  GfitHorizontalSlidingTabBarDelegateProtocol.h
//  gfitapp
//
//  Created by Gaurav Khanna on 2/8/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GfitHorizontalSlidingTabBarDelegateProtocol <NSObject>
@required

- (void)pushToViewController:(UIViewController *)viewController;

@end
