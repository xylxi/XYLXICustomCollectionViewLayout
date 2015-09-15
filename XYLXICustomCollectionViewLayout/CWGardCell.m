//
//  CWGardCell.m
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/15.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import "CWGardCell.h"

@implementation CWGardCell
- (void)awakeFromNib{
    self.contentView.layer.cornerRadius  = 10;
    self.contentView.layer.masksToBounds = YES;
}
@end
