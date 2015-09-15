//
//  CWWaterFallLayout.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWWaterFallLayout.h"
#import "CWGood.h"
@interface CWWaterFallLayout ()
@property (strong , nonatomic) NSArray *layoutAttributesArray;
@property (assign , nonatomic) CGSize   contentSize;
@end

@implementation CWWaterFallLayout

// 准备工作
- (void)prepareLayout{
    
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat marginX = self.minimumInteritemSpacing;
    NSLog(@"marginX = %f",marginX);
    CGFloat itemWidth = (contentWidth - marginX * (self.columnCount - 1)) / self.columnCount;
    
    // 计算出每个item的UICollectionViewLayoutAttributes
    [self computeAttributesWithItemWidth:itemWidth];
}

- (void)computeAttributesWithItemWidth:(CGFloat)itemWidth{
    CGFloat columnHeight[self.columnCount];
    CGFloat columnItemCount[self.columnCount];
    
    for (int i = 0; i<self.columnCount; i++) {
        columnHeight[i]    = self.sectionInset.top;
        columnItemCount[i] = 0;
    }
    
    NSInteger index = 0;
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:self.goodsList.count];
    for (CWGood *good in self.goodsList) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        NSInteger column = [self shortesColume:columnHeight];
        columnItemCount[column]++;
        
        CGFloat itemX = (itemWidth + self.minimumInteritemSpacing) * column + self.sectionInset.left;
        CGFloat itemY = columnHeight[column];
        CGFloat itmeH = good.h * itemWidth / good.w;
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itmeH);
        [attributesArray addObject:attributes];
        
        columnHeight[column] += itmeH + self.minimumInteritemSpacing;
        index++;
    }
    
    NSInteger column = [self highestColumn:columnHeight];
    self.contentSize = CGSizeMake(self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right, columnHeight[column]);
    
    self.layoutAttributesArray = attributesArray.copy;
}

- (NSInteger)shortesColume:(CGFloat *)columnHeigth{
    CGFloat max = CGFLOAT_MAX;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeigth[i] < max) {
            max = columnHeigth[i];
            column = i;
        }
    }
    return column;
}
- (NSInteger)highestColumn:(CGFloat *)columnHeight {
    CGFloat min = 0;
    NSInteger column = 0;
    for (int i = 0; i < self.columnCount; i++) {
        if (columnHeight[i] > min) {
            min = columnHeight[i];
            column = i;
        }
    }
    return column;
}

/**
 *  要覆盖的方法
 */
- (CGSize)collectionViewContentSize{
    return self.contentSize;
}

/**
 *  要覆盖的方法
 *  跟踪效果：当到达要显示的区域时 会计算所有显示item的属性
 *  一旦计算完成 所有的属性会被缓存 不会再次计算
 *  @param rect collectionView内容显示的位置
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *arr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *att in self.layoutAttributesArray) {
        if (CGRectIntersectsRect(att.frame, rect)) {
            [arr addObject:att];
        }
    }
    return arr;
}

@end
