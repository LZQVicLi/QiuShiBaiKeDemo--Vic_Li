//
//  QiushiListViewController.h
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiushiListViewController : UITableViewController
//根据页码请求对应数据的方法
- (void)acquireServerDataWithPageNumber:(NSInteger)page;
@property(nonatomic, retain)NSMutableArray *datasource;
@property(nonatomic, assign)NSInteger page;//保存当前已经下载的页码

@end
