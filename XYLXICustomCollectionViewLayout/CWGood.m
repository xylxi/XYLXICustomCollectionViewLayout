//
//  CWGood.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWGood.h"

@implementation CWGood
/**
 *  字典转模型
 */
+ (instancetype)goodWithDict:(NSDictionary *)dict {
    id good = [[self alloc] init];
    [good setValuesForKeysWithDictionary:dict];
    return good;
}

/**
 *  根据索引返回商品数组
 */
+ (NSArray *)goodsWithIndex:(NSInteger)index {
    
    NSString *fileName = [NSString stringWithFormat:@"%ld.plist", index % 3 + 1];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSArray *goodsArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:goodsArray.count];
    
    [goodsArray enumerateObjectsUsingBlock: ^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        [tmpArray addObject:[self goodWithDict:dict]];
    }];
    return tmpArray;
}
@end
