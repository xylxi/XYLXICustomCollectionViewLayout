//
//  CWWaterCollectionViewController.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWWaterCollectionViewController.h"
#import "CWGood.h"
#import "CWWaterFallLayout.h"
#import "CWWaterFallCell.h"
@interface CWWaterCollectionViewController ()

@property (nonatomic , strong) NSMutableArray *goodsList;
@property (nonatomic , assign) NSInteger       index;
@property (weak, nonatomic) IBOutlet CWWaterFallLayout *waterFallLayout;

@end

@implementation CWWaterCollectionViewController

static NSString * const reuseIdentifier = @"CWWaterFallCell";
- (NSMutableArray *)goodsList{
    if (_goodsList == nil) {
        _goodsList = [NSMutableArray array];
    }
    return _goodsList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData{
    NSArray *goods = [CWGood goodsWithIndex:self.index];
    [self.goodsList addObjectsFromArray:goods];
    self.index++;
    // 设置布局的属性
    self.waterFallLayout.columnCount = 3;
    self.waterFallLayout.goodsList = self.goodsList;
    // 刷新数据
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建可重用的cell
    CWWaterFallCell *cell = [collectionView
                                 dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                 forIndexPath:indexPath];
    cell.good = self.goodsList[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

@end
