//
//  QiushiSuggestCell.m
//  QiuShiBaiKeDemo
//
//  Created by xalo on 15/10/5.
//  Copyright © 2015年 蓝鸥科技. All rights reserved.
//

#import "QiushiSuggestCell.h"
#import "UIKit+AFNetworking.h"
@implementation QiushiSuggestCell




#define kPICURLFORMATE @"http://pic.qiushibaike.com/system/pictures/%@/%@/medium/%@"
- (void)configureCellWithModel:(QiushiModel *)model{
    [super configureCellWithModel:model];
    
    CGRect contentframe = self.content.frame;
    NSString *picURLstring = [NSString stringWithFormat:kPICURLFORMATE, [model.identifier substringToIndex:model.identifier.length - 4  ], model.identifier, model.image];
    [self.SuggestImagView setImageWithURL:[NSURL URLWithString:picURLstring]];
    CGFloat imageHight  = ([UIScreen mainScreen].bounds.size.width - 20) * model.imageHeigeht / model.imageWidth;
    CGRect imageFrame = self.SuggestImagView.frame;
    imageFrame.origin.y = contentframe.origin.y + CGRectGetHeight(contentframe);
    imageFrame.size.height = imageHight;
    //重写赋值给imageView
    self.SuggestImagView.frame = imageFrame;
    
    CGRect bottomFrame = self.bottomView.frame;;
    bottomFrame.origin.y = imageFrame.origin.y + imageHight;
    self.bottomView.frame = bottomFrame;
}





- (void)dealloc {
    [_SuggestImagView release];
    [super dealloc];
}
@end
