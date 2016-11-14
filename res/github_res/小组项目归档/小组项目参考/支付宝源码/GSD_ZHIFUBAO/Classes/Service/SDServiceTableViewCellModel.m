//
//  SDServiceTableViewCellModel.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDServiceTableViewCellModel.h"

@implementation SDServiceTableViewCellModel

+ (instancetype)modelWithTitle:(NSString *)title detailString:(NSString *)detailString iconImageURLString:(NSString *)iconImageURLString
{
    SDServiceTableViewCellModel *model = [[SDServiceTableViewCellModel alloc] init];
    model.title = title;
    model.detailString = detailString;
    model.iconImageURLString = iconImageURLString;
    return model;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com