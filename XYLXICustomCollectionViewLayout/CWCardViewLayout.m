//
//  CWCardViewLayout.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/15.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWCardViewLayout.h"

@interface CWCardViewLayout (){
    NSIndexPath *mainIndexPath;
    NSIndexPath *movingInIndexPath;
}

@end

@implementation CWCardViewLayout

- (void)prepareLayout{
    [super prepareLayout];
    [self setupLayout];
}

- (void)setupLayout{
    CGFloat inset = CGRectGetWidth(self.collectionView.bounds) * 6 / 64.0 ;
    inset = floor(inset);
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds) - 2*inset, CGRectGetHeight(self.collectionView.bounds)- 64 - 40 );
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes  = [super layoutAttributesForElementsInRect:rect];
    NSArray *cellIndices = [self.collectionView indexPathsForVisibleItems];

    if (cellIndices.count == 0) {
        return attributes;
    }else if (cellIndices.count == 1){
        mainIndexPath = cellIndices.firstObject;
        movingInIndexPath = nil;
    }else if (cellIndices.count > 1){
        NSIndexPath *firstIndexPath = cellIndices.firstObject;
        if(firstIndexPath == mainIndexPath){
            movingInIndexPath = cellIndices[1];
            NSLog(@"first is main");
        }
        else{
            NSLog(@"first is move");
            movingInIndexPath = cellIndices.firstObject;
            mainIndexPath     = cellIndices[1];
        }
    }
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [self applyTransformToLayoutAttribtutes:attribute];
    }
    return attributes;
}

- (void)applyTransformToLayoutAttribtutes:(UICollectionViewLayoutAttributes *)attribute{
    if (attribute.indexPath.section == mainIndexPath.section) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:attribute.indexPath];
        attribute.transform3D = [self transformFromView:cell];
    }else if (attribute.indexPath.section == movingInIndexPath.section){
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:movingInIndexPath];
        attribute.transform3D = [self transformFromView:cell];
    }
}

- (CATransform3D )transformFromView:(UIView *)cell{
    CGFloat angle = [self angleForView:cell];
    BOOL    xAxis = [self xAxisForView:cell];
    return [self transformfromAngle:angle xAxis:xAxis];
}

- (CGFloat)angleForView:(UIView *)view{
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view];
    CGFloat currentOffset            = self.collectionView.contentOffset.x;
    CGFloat scrollViewWidth          = self.collectionView.bounds.size.width;
    CGFloat angle                    = (currentOffset - baseOffsetForCurrentView) / scrollViewWidth;
    return angle;
}

/** 拿到cell在collectionView的contentView的x*/
- (CGFloat)baseOffsetForView:(UIView *)view{
    UICollectionViewCell *cell = (UICollectionViewCell *)view;
    CGFloat offset             = ([self.collectionView indexPathForCell:cell].section * CGRectGetWidth(self.collectionView.bounds));
    return offset;
}

- (BOOL)xAxisForView:(UIView *)view{
    CGFloat baseOffsetForCurrentView = [self baseOffsetForView:view];
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat offset = currentOffset - baseOffsetForCurrentView;
    if (offset >= 0) {
        return YES;
    }
    return NO;
}

- (CATransform3D)transformfromAngle:(CGFloat)angle
                              xAxis:(BOOL)axis{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0 / -500;
    if (axis) {
        t = CATransform3DRotate(t,angle,1,1,0);
    }else{
        t = CATransform3DRotate(t,angle,-1,1,0);
    }
    return t;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
