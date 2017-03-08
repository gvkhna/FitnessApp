//
//  RealTimePlot.m
//  CorePlotGallery
//

#import "RealTimePlot.h"

const double kFrameRate         = 5.0;  // frames per second
const double kAlpha             = 0.25; // smoothing constant
const NSUInteger kMaxDataPoints = 51;
NSString *kPlotIdentifier       = @"Data Source Plot";

@interface RealTimePlot () <CPTPlotDataSource>
@property (nonatomic, strong) NSMutableArray *plotData;
@property (nonatomic, strong) NSTimer *dataTimer;
@property (nonatomic, strong) NSNumber *currentIndex;

@end

@implementation RealTimePlot

//+(void)load
//{
//    [super registerPlotItem:self];
//}

-(instancetype)init
{
    if ( (self = [super init]) ) {
        self.plotData  = [[NSMutableArray alloc] initWithCapacity:kMaxDataPoints];
        self.dataTimer = nil;

        self.title   = @"Real Time Plot";
        self.section = kLinePlots;
    }

    return self;
}

-(void)killGraph
{
    [self.dataTimer invalidate];
    self.dataTimer = nil;

    [super killGraph];
}

-(void)generateData
{
    [self.plotData removeAllObjects];
    self.currentIndex = [NSNumber numberWithInt:0];
    self.dataTimer = [NSTimer timerWithTimeInterval:1.0 / kFrameRate
                                         target:self
                                       selector:@selector(newData:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.dataTimer forMode:NSDefaultRunLoopMode];
}

-(void)renderInLayer:(CPTGraphHostingView *)layerHostingView withTheme:(CPTTheme *)theme animated:(BOOL)animated
{
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    CGRect bounds = layerHostingView.bounds;
#else
    CGRect bounds = NSRectToCGRect(layerHostingView.bounds);
#endif

    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:bounds];
    [self addGraph:graph toHostingView:layerHostingView];
    [self applyTheme:theme toGraph:graph withDefault:[CPTTheme themeNamed:kCPTDarkGradientTheme]];

    [self setTitleDefaultsForGraph:graph withBounds:bounds];
    [self setPaddingDefaultsForGraph:graph withBounds:bounds];

    graph.plotAreaFrame.paddingTop    = 15.0;
    graph.plotAreaFrame.paddingRight  = 15.0;
    graph.plotAreaFrame.paddingBottom = 55.0;
    graph.plotAreaFrame.paddingLeft   = 55.0;
    graph.plotAreaFrame.masksToBorder = NO;

    // Grid line styles
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 0.75;
    majorGridLineStyle.lineColor = [[CPTColor colorWithGenericGray:0.2] colorWithAlphaComponent:0.75];

    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.25;
    minorGridLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:0.1];

    // Axes
    // X axis
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.labelingPolicy              = CPTAxisLabelingPolicyAutomatic;
    x.orthogonalCoordinateDecimal = CPTDecimalFromUnsignedInteger(0);
    x.majorGridLineStyle          = majorGridLineStyle;
    x.minorGridLineStyle          = minorGridLineStyle;
    x.minorTicksPerInterval       = 9;
    x.title                       = @"X Axis";
    x.titleOffset                 = 35.0;
    NSNumberFormatter *labelFormatter = [[NSNumberFormatter alloc] init];
    labelFormatter.numberStyle = NSNumberFormatterNoStyle;
    x.labelFormatter           = labelFormatter;

    // Y axis
    CPTXYAxis *y = axisSet.yAxis;
    y.labelingPolicy              = CPTAxisLabelingPolicyAutomatic;
    y.orthogonalCoordinateDecimal = CPTDecimalFromUnsignedInteger(0);
    y.majorGridLineStyle          = majorGridLineStyle;
    y.minorGridLineStyle          = minorGridLineStyle;
    y.minorTicksPerInterval       = 3;
    y.labelOffset                 = 5.0;
    y.title                       = @"Y Axis";
    y.titleOffset                 = 30.0;
    y.axisConstraints             = [CPTConstraints constraintWithLowerOffset:0.0];

    // Rotate the labels by 45 degrees, just to show it can be done.
    x.labelRotation = M_PI * 0.25;

    // Create the plot
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier     = kPlotIdentifier;
    dataSourceLinePlot.cachePrecision = CPTPlotCachePrecisionDouble;

    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth              = 3.0;
    lineStyle.lineColor              = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;

    // Put an area gradient under the plot above
    CPTColor *areaColor       = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    areaGradient.angle = -90.0;
    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
    dataSourceLinePlot.areaFill      = areaGradientFill;
    dataSourceLinePlot.areaBaseValue = CPTDecimalFromString(@"0.0");

    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];

    // Plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.allowsMomentum = YES;
    plotSpace.elasticGlobalXRange = YES;
    plotSpace.elasticGlobalYRange = YES;
//    plotSpace.globalXRange = CPTDecimalFromFloat(51);
//    plotSpace.globalYRange = CPTDecimalFromFloat(1);
    plotSpace.delegate = self;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(kMaxDataPoints - 1)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(0) length:CPTDecimalFromUnsignedInteger(1)];
}

-(void)dealloc
{
    [self.dataTimer invalidate];
}

#pragma mark -
#pragma mark Timer callback

-(void)newData:(NSTimer *)theTimer
{
    CPTGraph *theGraph = [self.graphs objectAtIndex:0];
    CPTPlot *thePlot   = [theGraph plotWithIdentifier:kPlotIdentifier];

    if ( thePlot  && self.plotData.count < 40) {
        if ( self.plotData.count >= kMaxDataPoints ) {
            [self.plotData removeObjectAtIndex:0];
            [thePlot deleteDataInIndexRange:NSMakeRange(0, 1)];
        }

        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)theGraph.defaultPlotSpace;
        NSUInteger location       = (self.currentIndex.intValue >= kMaxDataPoints ? self.currentIndex.intValue - kMaxDataPoints + 1 : 0);
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromUnsignedInteger(location)
                                                        length:CPTDecimalFromUnsignedInteger(kMaxDataPoints - 1)];

        self.currentIndex = [NSNumber numberWithInt:[self.currentIndex intValue] + 1];
        [self.plotData addObject:[NSNumber numberWithDouble:(1.0 - kAlpha) * [[self.plotData lastObject] doubleValue] + kAlpha * rand() / (double)RAND_MAX]];
        [thePlot insertDataAtIndex:self.plotData.count - 1 numberOfRecords:1];
    }
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    DLogINT([self.plotData count]);
    return [self.plotData count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSNumber *num = nil;

    switch ( fieldEnum ) {
        case CPTScatterPlotFieldX:
            num = [NSNumber numberWithUnsignedInteger:index + self.currentIndex.intValue - self.plotData.count];
            break;

        case CPTScatterPlotFieldY:
            num = [self.plotData objectAtIndex:index];
            break;

        default:
            break;
    }

    return num;
}

- (float)maxHeight {
    self.plotData;
}

#pragma mark -
#pragma mark Plot Space Delegate Methods

//-(void)scaleToFitPlots:(NSArray *)plots
//{
//    if ( plots.count == 0 ) {
//        return;
//    }
//
//    // Determine union of ranges
//    CPTMutablePlotRange *unionXRange = nil;
//    CPTMutablePlotRange *unionYRange = nil;
//    for ( CPTPlot *plot in plots ) {
//        CPTPlotRange *currentXRange = [plot plotRangeForCoordinate:CPTCoordinateX];
//        CPTPlotRange *currentYRange = [plot plotRangeForCoordinate:CPTCoordinateY];
//        if ( !unionXRange ) {
//            unionXRange = [currentXRange mutableCopy];
//        }
//        if ( !unionYRange ) {
//            unionYRange = [currentYRange mutableCopy];
//        }
//        [unionXRange unionPlotRange:currentXRange];
//        [unionYRange unionPlotRange:currentYRange];
//    }
//
//    // Set range
//    NSDecimal zero = CPTDecimalFromInteger(0);
//    if ( unionXRange ) {
//        if ( CPTDecimalEquals(unionXRange.length, zero) ) {
//            [unionXRange unionPlotRange:self.xRange];
//        }
//        self.xRange = unionXRange;
//    }
//    if ( unionYRange ) {
//        if ( CPTDecimalEquals(unionYRange.length, zero) ) {
//            [unionYRange unionPlotRange:self.yRange];
//        }
//        self.yRange = unionYRange;
//    }
//}

-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate
{
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)[[self.graphs objectAtIndex:0] defaultPlotSpace];
    // Impose a limit on how far user can scroll in x
    if ( coordinate == CPTCoordinateX ) {
        CPTPlotRange *maxRange            = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(self.plotData.count)];
        CPTMutablePlotRange *changedRange = [newRange mutableCopy];
        //[changedRange shiftEndToFitInRange:maxRange];
        //[changedRange shiftLocationToFitInRange:maxRange];
        //newRange = maxRange;
        plotSpace.globalXRange = maxRange;
    }
    if ( coordinate == CPTCoordinateY ) {

        CPTPlotRange *maxRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(1)];
        //newRange = maxRange;
        plotSpace.globalYRange = maxRange;
    }
    return newRange;
}


@end
