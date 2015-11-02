//
//  QiushiItemCell.h
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiushiModel.h"

@interface QiushiItemCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *userAvatar;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *content;
@property (retain, nonatomic) IBOutlet UIView *bottomView;


- (void)con0figureCellWithModel:(QiushiModel *)model;

@end
