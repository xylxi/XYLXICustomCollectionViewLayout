//
//  CWWaterFallCell.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWWaterFallCell.h"
#import "UIImageView+WebCache.h"
@interface CWWaterFallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imagePic;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation CWWaterFallCell

- (void)setGood:(CWGood *)good{
    _priceLabel.text = good.price;
    
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:good.img]];
}

@end
