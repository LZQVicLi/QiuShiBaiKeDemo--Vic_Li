//
//  MyselfModel.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "MyselfModel.h"

@implementation MyselfModel


- (void)dealloc
{
    [_image release];
    [_title release];
    [super dealloc];
}
@end
