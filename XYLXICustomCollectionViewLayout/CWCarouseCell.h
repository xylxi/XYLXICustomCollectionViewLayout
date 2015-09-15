//
//  CWCarouseCell.h
//  XYLXICustomCollectionViewLayout
//
//  Created by WangZHW on 15/9/14.
//  Copyright (c) 2015年 XYXLI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWCarouseCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagePic;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (strong , nonatomic) UIColor *color;
@end
