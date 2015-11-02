//
//  SuggestListViewController.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/10/5.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "SuggestListViewController.h"
#import "QiushiSuggestCell.h"
#import "AFNetworking.h"
#import "QiushiModel.h"
@interface SuggestListViewController ()

@end

@implementation SuggestListViewController
//实现自定义方法
- (void)acquireServerDataWithPageNumber:(NSInteger)page{
    NSString *URLString = [NSString stringWithFormat: @"http://m2.qiushibaike.com/article/list/suggest?count=30&readarticles=%%5B113191621%%2C113190356%%2C113184604%%5D&page=%ld&AdID=1444011078223727F1E73A",page];
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



- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.datasource.count && self.datasource.count > 0 ) {
        QiushiModel *model = self.datasource[indexPath.row];
        if (model.image) {
            QiushiSuggestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMGCELL" forIndexPath:indexPath];
            [cell configureCellWithModel:model];
            return cell;
        }
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if (indexPath.row < self.datasource.count && self.datasource.count > 0 ) {
        QiushiModel *model = self.datasource[indexPath.row];
        if (model.image) {
            
            height +=(([UIScreen mainScreen].bounds.size.width - 20)* model.imageHeigeht / model.imageWidth);
        }
    }
    
    return height;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
