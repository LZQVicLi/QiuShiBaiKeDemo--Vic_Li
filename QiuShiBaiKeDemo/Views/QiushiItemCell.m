//
//  QiushiItemCell.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "QiushiItemCell.h"
#import "UIKit+AFNetworking.h"

@interface QiushiItemCell ()


@end


@implementation QiushiItemCell


  //类似初始化的方法
- (void)awakeFromNib {
    // Initialization code
    self.userAvatar.layer.cornerRadius = 30;
    self.userAvatar.layer.masksToBounds = YES;
}



//实现自定义方法(在cell中实现单元格的赋值)
  #define kAvatarURLFormat @"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@"
- (void)configureCellWithModel:(QiushiModel *)model{
    
    self.content.text = model.content;

    if (model.user.identifier) {
        self.userName.text = model.user.login;
        NSString *picURLString = [NSString stringWithFormat:kAvatarURLFormat,[model.user.identifier.stringValue substringToIndex:model.user.identifier.stringValue.length - 4],model.user.identifier,model.user.icon];
        //加载对应网址的图片
        [self.userAvatar setImageWithURL:[NSURL URLWithString:picURLString]];
        
    }else{
        self.userName.text = @"匿名用户";
        self.userAvatar.image = [UIImage imageNamed:@"user_icon_anonymous"];
    }
    
    for (id object in self.bottomView.subviews) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *timeLabel = (UILabel *)object;
             NSDate *publishData = [NSDate dateWithTimeIntervalSince1970:model.published_at.doubleValue];//将时间戳转成日期
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];//将日期格式化
            //设置日期格式字符串
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *timeSting = [formatter stringFromDate:publishData];
            [formatter release];
            timeLabel.text = timeSting;
        }
    
    }

    
    CGRect contentFrame = self.content.frame;
    contentFrame.size.height = model.contentHeight;
    self.content.frame = contentFrame;
    
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.origin.y = contentFrame.origin.y + model.contentHeight;
    self.bottomView.frame = bottomFrame;
    
//    NSLog(@"%@", [UIFont familyNames]);
//    NSLog( @"%@", [UIFont fontNamesForFamilyName:@"STLiti"]);
    self.content.font = [UIFont fontWithName:@"STLiti" size:20];
    self.userName.font = [UIFont fontWithName:@"STLiti" size:25];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_userAvatar release];
    [_userName release];
    [_content release];
    [_bottomView release];
    [super dealloc];
}
@end
