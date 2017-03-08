//
//  GfitContentNavigationBar.h
//  gfitapp
//
//  Created by Gaurav Khanna on 4/25/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GfitContentNavigationBarDelegateProtocol <NSObject>

- (void)navigationBarBackToMainMenu:(id)sender;

@end

@interface GfitContentNavigationBar : UINavigationBar

@property (nonatomic, weak) id<GfitContentNavigationBarDelegateProtocol> mainMenuNavigationDelegate;

- (void)tryToPush;

@end
