//
//  SDAssetsTableViewControllerCellModel.h
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDAssetsTableViewControllerCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconImageName;
@property (nonatomic, copy) Class destinationControllerClass;

+ (instancetype)modelWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName destinationControllerClass:(Class)destinationControllerClass;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com