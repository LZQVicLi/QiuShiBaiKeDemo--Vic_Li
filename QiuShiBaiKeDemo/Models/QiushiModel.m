
//
//  QiushiModel.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/9/30.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "QiushiModel.h"

@implementation QiushiModel



- (void)dealloc
{
    [_identifier release];
    [_image release];
    [_comments_count release];
    [_published_at release];
    [_user release];
    [_content release];
    [super dealloc];
}

- (instancetype)init{
    if (self = [super init]) {
        self.user = [[[UserModel alloc]init]autorelease];
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog( @"%@",key);
    if ([key isEqualToString:@"image_size"]) {
        NSArray *imageSize = [value objectForKey:@"m"];
        self.imageWidth = [imageSize[0]doubleValue];
        self.imageHeigeht = [imageSize[1]doubleValue];
    }
    
    
    if ([key isEqualToString:@"id"]) {
        self.identifier  = [value stringValue];
    }
}



- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"user"]) {
        [self.user setValuesForKeysWithDictionary:value];
    }else{
        [super setValue:value forKey:key];
    }
}

- (CGFloat)contentHeight{
    CGRect rect = [self.content boundingRectWithSize:CGSizeMake(355, 1000000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    return rect.size.height;
}



@end
