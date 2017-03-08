//
//  GfitMenuGridLayout.m
//  gfitapp
//
//  Created by Gaurav Khanna on 12/17/13.
//  Copyright (c) 2013 Gaurav Khanna. All rights reserved.
//

#import "GfitMenuGridLayout.h"
#import "GfitMenuGridController.h"

@implementation GfitMenuGridLayout

#pragma mark - Preferred Sizing Methods

//- (CGSize)collectionViewContentSize {
//    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
//        return CGSizeMake(self.itemSize.width*2, self.itemSize.height*2);
//    }
//    return CGSizeMake(self.itemSize.width*4, self.itemSize.height);
////    return self.collectionView.frame.size;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(self.itemSize.width*2, self.itemSize.height*2);
    }
    return CGSizeMake(self.itemSize.width*4, self.itemSize.height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - Layout Update Methods

- (void)prepareLayout {
    [super prepareLayout];
    @autoreleasepool {
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        self.headerReferenceSize = CGSizeZero;
        self.footerReferenceSize = CGSizeZero;
        self.sectionInset = UIEdgeInsetsMake(0, kGfitMenuGridMargin, 0, kGfitMenuGridMargin);
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            self.sectionInset = UIEdgeInsetsMake(0, kGfitMenuGridMargin - 10, 0, kGfitMenuGridMargin - 10);
            UIEdgeInsets rectInset = UIEdgeInsetsMake(0, (kGfitMenuGridMargin + 20), 0, (kGfitMenuGridMargin));
            CGRect insetRect = UIEdgeInsetsInsetRect(self.collectionView.frame, rectInset);
            self.itemSize = CGSizeMake(insetRect.size.width / 4, insetRect.size.height);
            return;
        }
        UIEdgeInsets rectInset = UIEdgeInsetsMake(0, (kGfitMenuGridMargin*2), 0, (kGfitMenuGridMargin*4));
        CGRect insetRect = UIEdgeInsetsInsetRect(self.collectionView.frame, rectInset);
        self.itemSize = CGSizeMake(CGRectGetMidX(insetRect), CGRectGetMidY(insetRect));
    }
}

@end
