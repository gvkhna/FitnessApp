//
//  GfitHueViewController.h
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import <GLKit/GLKit.h>

/**
 *  Displays the animated hue color changing background of the main menu view
 */
@interface GfitHueViewController : GLKViewController <UILayoutSupport>

- (id<UILayoutSupport>)topLayoutGuide;

@end