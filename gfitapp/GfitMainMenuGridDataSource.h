//
//  GfitMainMenuGridDataSource.h
//  gfitapp
//
//  Created by Gaurav Khanna on 1/18/14.
//  Copyright (c) 2014 Gaurav Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GfitMenuGridControllerDataSource.h"

@interface GfitMainMenuGridDataSource : NSObject <GfitMenuGridControllerDataSource>

- (UIViewController *)mainMenuGridDidSelectItemAtIndexPath:(NSIndexPath*)indexPath;

@end
