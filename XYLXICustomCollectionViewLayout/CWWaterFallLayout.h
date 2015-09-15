//
//  CWWaterFallLayout.h
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWWaterFallLayout : UICollectionViewFlowLayout

/**列数*/
@property (assign , nonatomic) NSInteger columnCount;

/**cell的个数*/
@property (strong , nonatomic) NSArray *goodsList;

@end
