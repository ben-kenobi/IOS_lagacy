//
//  SDServiceTableViewCell.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDServiceTableViewCell.h"
#import "SDServiceTableViewCellModel.h"
#import "UIImageView+WebCache.h"

@implementation SDServiceTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    SDServiceTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SDServiceTableViewCell" owner:nil options:nil] lastObject];
    cell.iconView.layer.cornerRadius = 4;
    cell.iconView.clipsToBounds = YES;

    return cell;
}

- (void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    SDServiceTableViewCellModel *cellModel = (SDServiceTableViewCellModel *)model;
    
    self.titleLabel.text = cellModel.title;
    self.detailLabel.text = cellModel.detailString;
    [self.iconView setImageWithURL:[NSURL URLWithString:cellModel.iconImageURLString] placeholderImage:nil];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com