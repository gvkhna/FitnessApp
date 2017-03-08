//
//  UIView+GAnimateBlock.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/9/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GAnimateBlock)

+ (void)g_performAnimations:(BOOL)animate blockOperation:(NSBlockOperation*)updateOperation;

@end
