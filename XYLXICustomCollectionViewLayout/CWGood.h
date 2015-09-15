//
//  CWGood.h
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWGood : NSObject
@property (nonatomic, assign) NSInteger h; // 商品图片高
@property (nonatomic, assign) NSInteger w; // 商品图片宽
@property (nonatomic, copy) NSString *img; // 商品图片地址
@property (nonatomic, copy) NSString *price; // 商品价格

+ (instancetype)goodWithDict:(NSDictionary *)dict; // 字典转模型
+ (NSArray *)goodsWithIndex:(NSInteger)index; // 根据索引返回商品数组
@end
