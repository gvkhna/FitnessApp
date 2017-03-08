//
//  GfitMenuGridController.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitMenuGridController.h"
#import "GfitMenuGridControllerView.h"
#import "GfitMenuGridLayout.h"
#import "GfitMenuGridCell.h"
#import "gfitapp-Constants.h"
#import "GfitSerialOperationQueue.h"

static const CGFloat kGfitMainScreenImageHeight = 337;
static const CGFloat kGfitMenuGridControllerTopInset = 45;
static const CGFloat kGfitMenuGridControllerTopMargin = kGfitMainScreenImageHeight - kGfitMenuGridControllerTopInset;

#define GfitMenuGridController_DEBUG_BACKGROUND_COLOR 0

static NSString *CellIdentifier = @"GfitMenuGridControllerCell";

@interface GfitMenuGridController () <UICollectionViewDelegate, UICollectionViewDataSource>

//@property (nonatomic, strong) GfitMenuGridControllerView *collectionView;

@property (nonatomic, strong) GfitSerialOperationQueue *operationQueue;

@end

@implementation GfitMenuGridController

#pragma mark - Object Setup Methods

/**
 *  Designated initializer
 *
 *  @return fully initialized object
 */
- (instancetype)initWithDataSource:(id<GfitMenuGridControllerDataSource>)dataSource {
    self = [super initWithCollectionViewLayout:[GfitMenuGridLayout new]];
    if (self) {
        self.dataSource = dataSource;
    }
    return self;
}

//- (void)loadView {
//    //[super loadView];
//    self.view = [[GfitMenuGridControllerView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    @autoreleasepool {
#if GfitMenuGridController_DEBUG_BACKGROUND_COLOR
        self.collectionView.backgroundColor = [UIColor redColor];
#else
        self.collectionView.backgroundColor = [UIColor clearColor];
#endif

        //self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;

        self.collectionView.scrollEnabled = NO;

        [self.collectionView registerClass:[GfitMenuGridCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.operationQueue = [[GfitSerialOperationQueue alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {

    [self.operationQueue cancelAllOperations];
    self.operationQueue = nil;

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    //self.dataSource = nil;
    //self.delegate = nil;
}

#pragma mark - View Controller Container Methods

/**
 *  Returns the preferred size of the view
 *
 *  @return preferred size of bottom section of the screen
 */
//- (CGSize)preferredContentSize {
//    @autoreleasepool {
//        DLogCGRect(self.navigationController.view.bounds);
//
//    }
//}

- (CGRect)preferredContentFrame:(CGRect)bounds {
    CGSize preferredSize = bounds.size;
    const CGFloat preferredHeight = preferredSize.height - kGfitMenuGridControllerTopMargin - kGfitMenuGridMargin;
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        const CGFloat topMargin = 200;
        return CGRectMake(0, 200, preferredSize.width, preferredSize.height - topMargin);
    }
    return CGRectMake(0, CGRectGetHeight(bounds) - preferredHeight - [self.bottomLayoutGuide length], preferredSize.width, preferredHeight);
    //}
    //return CGRectMake(0, CGRectGetHeight(bounds) - , <#CGFloat width#>, <#CGFloat height#>)
    //DLogCGRect(self.view.bounds);
    //DLogCGSize(CGSizeMake(preferredSize.width, preferredSize.height - kGfitMenuGridControllerTopMargin - kGfitMenuGridMargin));

}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [self.collectionView performBatchUpdates:nil completion:nil];
////    [self.collectionViewLayout invalidateLayout];
////    [self.collectionView setCollectionViewLayout:[GfitMenuGridLayout new] animated:YES];
////    GfitMenuGridController * __weak weakSelf = self;
////    [self.collectionView performBatchUpdates:^{
////        [weakSelf.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathWithIndexes:0 length:4]]];
////    } completion:^(BOOL finished) {
////        [weakSelf.collectionView reloadData];
////    }];
//}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//    [self.collectionView performBatchUpdates:^{
//        NSIndexPath *zero = [NSIndexPath indexPathWithIndex:0];
//        NSIndexPath *one = [NSIndexPath indexPathWithIndex:1];
//        NSIndexPath *two = [NSIndexPath indexPathWithIndex:2];
//        NSIndexPath *three = [NSIndexPath indexPathWithIndex:3];
//        [self.collectionView moveItemAtIndexPath:zero toIndexPath:zero];
//        [self.collectionView moveItemAtIndexPath:one toIndexPath:two];
//        [self.collectionView moveItemAtIndexPath:two toIndexPath:one];
//        [self.collectionView moveItemAtIndexPath:three toIndexPath:three];
//    } completion:^(BOOL finished) {
//        [self.collectionView reloadData];
//    }];
//}

#pragma mark - UILayoutSupport Protocol Methods

/**
 *  Support for UILayoutSupport protocol
 *
 *  @return the length for the bottomLayoutGuide
 */
- (CGFloat)length {
    return kGfitMenuGridMargin;
}

/**
 *  View Controller Layout support for bottomLayoutGuide
 *
 *  @return object implementing protocol
 */
- (id<UILayoutSupport>)bottomLayoutGuide {
    return self;
}

#pragma mark - CollectionView DataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        GfitMenuGridCell *cell = (GfitMenuGridCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

        //NSAssert([self.dataSource respondsToSelector:@selector(gridControllerWillDisplayCell:atIndexPath:)], @"gridControllerWillDisplayCellButton:forItemAtIndexPath:%@", self.dataSource);

        NSAssert([cell conformsToProtocol:@protocol(GfitMenuGridCellContent)], @"UICollectionViewCell must conform to GfitMenuGridCellContent Protocol: %@", cell);

        if ([self.dataSource respondsToSelector:@selector(gridControllerWillDisplayCell:atIndexPath:)]) {
            [self.dataSource performSelector:@selector(gridControllerWillDisplayCell:atIndexPath:) withObject:cell withObject:indexPath];
        }

        NSParameterAssert(cell.title != nil);
        NSParameterAssert(cell.image != nil);

        // required for updates to be displayed
        [cell setNeedsLayout];

        return cell;
    }
}

#pragma mark - CollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GfitMenuGridController * __weak weakSelf = self;
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    NSBlockOperation * __weak weakOperation = blockOperation;
    [blockOperation addExecutionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            GfitMenuGridController *strongSelf = weakSelf;
            if ([weakOperation isCancelled]) {
                return;
            }

            //NSAssert([strongSelf.delegate respondsToSelector:@selector(gridControllerDidSelectItemAtIndexPath:)], @"gridControllerDidSelectItemAtIndexPath: required to be implemented by dataSource:%@", strongSelf.dataSource);
            if ([strongSelf.delegate respondsToSelector:@selector(gridControllerDidSelectItemAtIndexPath:)]) {
                [strongSelf.delegate performSelector:@selector(gridControllerDidSelectItemAtIndexPath:) withObject:indexPath];
            }
        });
    }];
    [self.operationQueue addOperation:blockOperation];
}

@end
