//
//  QiushiModel.h
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface QiushiModel : NSObject

@property(nonatomic, retain)UserModel *user;
@property(nonatomic, retain)NSNumber *published_at;
@property(nonatomic, retain)NSString *content;
@property(nonatomic, retain)NSNumber *comments_count;
@property(nonatomic, retain)NSString *image;
@property(nonatomic, assign)CGFloat imageHeigeht;
@property(nonatomic, assign)CGFloat imageWidth;
@property(nonatomic, retain)NSString *identifier;

@property(nonatomic, assign)CGFloat contentHeight;
@end
