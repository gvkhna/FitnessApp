//
//  DetailViewController.h
//  CorePlotGallery
//
//  Created by Jeff Buck on 8/28/10.
//  Copyright Jeff Buck 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

//@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) PlotItem *detailItem;
@property (nonatomic, retain) UIView *hostingView;

- (CPTTheme *)currentTheme;

@end
