//
//  GfitContentNavigationBar.m
//  gfitapp
//
//  Created by Gaurav Khanna on 4/25/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import "GfitContentNavigationBar.h"

@interface GfitContentNavigationBar ()

@property (nonatomic, strong) UINavigationItem *tempNavigationItem;

@end

@implementation GfitContentNavigationBar

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//
//    DLogObject(touches);
//    DLogObject(event);
//    [super touchesEnded:touches withEvent:event];
//}

//- (void)tryToPush {
//    if (self.tempNavigationItem) {
//        [self pushNavigationItem:self.tempNavigationItem animated:NO];
//        self.tempNavigationItem = nil;
//    }
//}

//- (UINavigationItem*)popNavigationItemAnimated:(BOOL)animated {
//    DLogFunctionLine();
//    if ([[self items] count] == 2) {
//        //UINavigationItem *poppedItem = [super popNavigationItemAnimated:animated];
//        //DLogObject(poppedItem);
//        //self.tempNavigationItem = poppedItem;
//        if ([self.mainMenuNavigationDelegate respondsToSelector:@selector(navigationBarBackToMainMenu:)]) {
//            [self.mainMenuNavigationDelegate performSelector:@selector(navigationBarBackToMainMenu:) withObject:self];
//        }
//        //return poppedItem;
//
//        return nil;
//    } else {
//        UINavigationItem *poppedItem = [super popNavigationItemAnimated:animated];
//        DLogObject(poppedItem);
//        return poppedItem;
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
