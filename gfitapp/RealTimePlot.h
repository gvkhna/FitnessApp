//
//  RealTimePlot.h
//  CorePlotGallery
//

#import "PlotItem.h"

@interface RealTimePlot : PlotItem

-(void)newData:(NSTimer *)theTimer;

@end
