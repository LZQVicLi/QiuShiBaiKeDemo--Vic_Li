//
//  PicListViewController.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/10/5.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "PicListViewController.h"
#import "AFNetworking.h"
#import "QiushiModel.h"
@interface PicListViewController ()

@end

@implementation PicListViewController


//实现自定义方法
- (void)acquireServerDataWithPageNumber:(NSInteger)page{
    NSString *URLString = [NSString stringWithFormat: @"http://m2.qiushibaike.com/article/list/imgrank?count=30&readarticles=%%5B113179837%%2C113135852%%2C113188812%%2C113189234%%2C113190534%%2C113189400%%2C113185548%%2C113185146%%5D&page=%ld&AdID=1444037821105527F1E73A",page];
    NSLog( @"%@", URLString);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //        NSLog( @"%@", operation);
        
        //当数据下载完成是结束刷新
        [self.refreshControl endRefreshing];
        if(self.page == 1 ){
            //判断如果是下拉刷新  则清空数组原有对象
            [self.datasource removeAllObjects];
        }
        
        
        NSArray *sourceArray = [responseObject objectForKey:@"items"];
        
        for (NSDictionary *dict in sourceArray) {
            QiushiModel *model = [[[QiushiModel alloc]init] autorelease];
            [model setValuesForKeysWithDictionary:dict];
            [self.datasource addObject:model];
            
        }
   
        
        if(self.page == 1){
            [self.tableView reloadData];
        }else{
            [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:3];
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog( @"%@", error);
    }];
    
}


@end
