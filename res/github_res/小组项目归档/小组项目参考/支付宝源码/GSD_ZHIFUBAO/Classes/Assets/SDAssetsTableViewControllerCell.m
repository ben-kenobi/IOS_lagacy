//
//  SDAssetsTableViewControllerCell.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDAssetsTableViewControllerCell.h"
#import "SDAssetsTableViewControllerCellModel.h"

@implementation SDAssetsTableViewControllerCell

- (void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    SDAssetsTableViewControllerCellModel *cellModel = (SDAssetsTableViewControllerCellModel *)model;
    
    self.textLabel.text = cellModel.title;
    self.imageView.image = [UIImage imageNamed:cellModel.iconImageName];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com