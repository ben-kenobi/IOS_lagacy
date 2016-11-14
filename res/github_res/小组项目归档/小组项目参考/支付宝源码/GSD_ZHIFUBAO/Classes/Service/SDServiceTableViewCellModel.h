//
//  SDServiceTableViewCellModel.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDServiceTableViewCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailString;
@property (nonatomic, copy) NSString *iconImageURLString;

+ (instancetype)modelWithTitle:(NSString *)title detailString:(NSString *)detailString iconImageURLString:(NSString *)iconImageURLString;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com