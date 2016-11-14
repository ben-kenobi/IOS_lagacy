//
//  YFNewsTVCell.h
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFNews;

@interface YFNewsTVCell : UITableViewCell

@property (nonatomic,strong)YFNews *news;


+(instancetype)cellWithTv:(UITableView *)tv news:(YFNews *)news;
@end
