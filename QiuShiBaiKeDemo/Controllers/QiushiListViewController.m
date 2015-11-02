//
//  QiushiListViewController.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "QiushiListViewController.h"
#import "UIKit+AFNetworking.h"
#import "QiushiModel.h"
#import "AFNetworking.h"
#import "QiushiItemCell.h"


@interface QiushiListViewController ()








@end

@implementation QiushiListViewController

- (void)dealloc
{
    [_datasource release];
    [super dealloc ];
    
}

- (NSMutableArray *)datasource{
    if ( !_datasource ) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}


//实现自定义方法
- (void)acquireServerDataWithPageNumber:(NSInteger)page{
    NSString *URLString = [NSString stringWithFormat: @"http://m2.qiushibaike.com/article/list/text?count=30&readarticles=%%5B113067229%%2C113049786%%2C113049938%%5D&page=%ld&AdID=1443425077789327F1E73A", page];
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
        //一定要在封装完成后重新加载数据
//        [self.tableView reloadData];
       
        //让对象调用的方法延迟一定时间执行
//        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:3];
        
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //刷新时的动画控件
    self.refreshControl = [[[UIRefreshControl alloc]initWithFrame:CGRectZero] autorelease];
    //这是iOS6之后的下拉刷新控件  仅限UITableViewController使用
    [self.refreshControl addTarget:self action:@selector(handleRefreshAction:) forControlEvents:UIControlEventValueChanged];
    //手动执行开始刷新动画
    [self.refreshControl beginRefreshing];
    [self handleRefreshAction: self.refreshControl];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
}

//下拉刷新动作实现方法
- (void)handleRefreshAction:(UIRefreshControl *)sender{
    self.page = 1;
    [self acquireServerDataWithPageNumber:self.page];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (self.datasource.count == 0 ) {
        return self.datasource.count;
    }
    return self.datasource.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.row == self.datasource.count && self.datasource.count > 0 ) {
        return [tableView dequeueReusableCellWithIdentifier:@"LOAD" forIndexPath:indexPath];
    }    
    QiushiItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
 
    // Configure the cell...
    QiushiModel *model = self.datasource[indexPath.row];
    [cell configureCellWithModel:model];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *content = model.content;
//    CGRect rect = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.bounds), 100000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    if (indexPath.row == self.datasource.count && self.datasource.count > 0 ) {
        return 50;
    }
    
    QiushiModel *model = self.datasource[indexPath.row];
    
    return model.contentHeight + 78 + 74;

}




- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasource.count > 0 && indexPath.row == self.datasource.count ) {
    //说明当前是最后一行数据  下拉加载下一页数据
        self.page ++;
        [self acquireServerDataWithPageNumber:self.page];
    }
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
