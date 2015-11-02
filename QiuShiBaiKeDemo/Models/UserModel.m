//
//  UserModel.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


- (void)dealloc
{
    [_identifier release];
    [_login release];
    [_icon release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.identifier = value;
    }
}

@end

