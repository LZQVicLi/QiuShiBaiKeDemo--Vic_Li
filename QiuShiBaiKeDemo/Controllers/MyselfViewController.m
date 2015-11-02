//
//  MyselfViewController.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "MyselfViewController.h"
#import "MyselfModel.h"
@interface MyselfViewController ()
@property(nonatomic, retain)NSMutableArray *datasource;
@end

@implementation MyselfViewController


- (void)dealloc
{
    [_datasource release];
    [super dealloc];
}


- (NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSString *sourcePath = [[NSBundle mainBundle]pathForResource:@"Myself_hardCode" ofType:@"plist"];
    NSArray *sourceArray = [NSArray arrayWithContentsOfFile:sourcePath];
    
    for (int i = 0 ; i < sourceArray.count; i ++) {
        NSMutableArray *array = [NSMutableArray array];
        [self.datasource addObject:array];
        //得到对下表的内层数组对象
        NSArray *innerArray = sourceArray[i];
        //快速便利内层数组
        for (NSDictionary *dict  in innerArray) {
            //创建model对象
            MyselfModel *model = [[[MyselfModel alloc]init] autorelease];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [self.datasource[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = indexPath.section == 2 && indexPath.row == 0 ? @"SWITCH" : @"DEFAULT";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    MyselfModel *model = [self.datasource[indexPath.section]objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:model.image];
    cell.textLabel.text = model.title;
    if ([cell.reuseIdentifier isEqualToString:@"SWITCH"]) {
        UISwitch *aSwitch = [[[UISwitch alloc]init]autorelease];
        aSwitch.on = YES;
        aSwitch.thumbTintColor = [UIColor grayColor];
        aSwitch.tintColor = [UIColor orangeColor];
        aSwitch.onTintColor = [UIColor orangeColor];
        //单元格的赋值视图
        cell.accessoryView = aSwitch;
    }
    // Configure the cell...
    
    return cell;
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
