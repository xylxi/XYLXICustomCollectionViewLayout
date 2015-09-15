//
//  CWCarouselViewLayout.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWCarouselViewLayout.h"

@interface CWCarouselViewLayout (){
    CGFloat _viewHeight;
    CGFloat _itemHeight;
}

@end

@implementation CWCarouselViewLayout

- (void)prepareLayout{
    [super prepareLayout];
    _visibleCount = 3;
    _itemSize     = CGSizeMake(250, 250);
    _viewHeight = CGRectGetHeight(self.collectionView.frame);
    _itemHeight = self.itemSize.height;
    self.collectionView.contentInset = UIEdgeInsetsMake((_viewHeight - _itemHeight ) / 2.0, 0, (_viewHeight - _itemHeight) / 2.0, 0);
}

- (CGSize)collectionViewContentSize{
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), cellCount * _itemHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    // 指的是，collectionView的内容哪个点出现在collectionView能显示view的中心位置
    CGFloat centerY = self.collectionView.contentOffset.y + _viewHeight / 2;
    /**
     *  这个方法里主要确认了当前rect中
     *  改显示的IndexPath是哪些
     */
    // 当前滑动到的中心cell是下标
    NSInteger index = centerY / _itemHeight;
    // 一个collectionView能显示几个
    NSInteger count = _viewHeight / _itemHeight;
    // collectionView能显示屏幕中显示的最小的cell下标
    NSInteger minIndex = MAX(0, (index - count));
    // collectionView能显示屏幕中显示的最大的cell下标
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    // 创建对应的UICollectionViewLayoutAttributes属性
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [arr addObject:attributes];
    }
    return arr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 设置每个cell的大小
    attributes.size = self.itemSize;
    // collectionView滑动后，在屏幕的中心点位置
    // 指的是，collectionView的哪个点出现在控制器view的中心位置
    CGFloat cY = self.collectionView.contentOffset.y + _viewHeight / 2;
    // 改cell的center.y值
    CGFloat attributesY = _itemHeight * indexPath.row + _itemHeight / 2;
    // 偏移量 当前的cell的中心位置相对于屏幕的中心位置的偏移量
    CGFloat delta = cY - attributesY;
    // 根据偏移量得出缩放大小
    CGFloat scale = 1 - (ABS(delta) / _itemHeight) * 0.3;
    // 设置transform属性
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    attributes.center = CGPointMake(CGRectGetWidth(self.collectionView.frame) / 2.0 , attributesY);
    // 返回layout布局属性
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    // 获取中心位置
    CGFloat centerY = proposedContentOffset.y + _viewHeight / 2.0;
    // 获取cell的自身中心位置
    CGFloat itemCenterY = _itemHeight / 2.0;
    // 获得对应的cell下标
    CGFloat findex = ( centerY - itemCenterY ) / _itemHeight;
    // 四舍五入的到下标
    CGFloat index = roundf (findex);
    proposedContentOffset.y = _itemHeight * index + _itemHeight / 2 - _viewHeight / 2;
    return proposedContentOffset;
}

/**
 *  因为layoutAttributesForElementsInRect为缓存计算过的rect的UICollectionViewLayoutAttributes属性，所以在滑动对时候，如果在这个方法中不返回YES的话，不用根据滑动的位置重新计算，就没有缩放的效果
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
