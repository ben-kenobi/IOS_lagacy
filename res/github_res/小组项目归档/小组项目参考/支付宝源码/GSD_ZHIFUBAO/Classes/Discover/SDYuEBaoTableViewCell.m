//
//  SDYuEBaoTableViewCell.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDYuEBaoTableViewCell.h"
#import "SDYuEBaoTableViewCellContentView.h"
#import "SDYuEBaoTableViewCellModel.h"

const CGFloat kSDYuEBaoTableViewCellHeight = 550.0;

@implementation SDYuEBaoTableViewCell
{
    SDYuEBaoTableViewCellContentView *_cellContentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        SDYuEBaoTableViewCellContentView *contentView = [[SDYuEBaoTableViewCellContentView alloc] init];
        [self.contentView addSubview:contentView];
        _cellContentView = contentView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


// 重写父类方法
- (void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    SDYuEBaoTableViewCellModel *cellModel = (SDYuEBaoTableViewCellModel *)model;
    
    _cellContentView.totalMoneyAmount = cellModel.totalMoneyAmount;
    _cellContentView.yesterdayIncome = cellModel.yesterdayIncome;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com