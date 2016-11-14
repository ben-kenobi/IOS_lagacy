//
//  YFDiscCell.h
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFDiscCell : UITableViewCell

@property (nonatomic,strong)NSDictionary *dict;

+(instancetype)cellWithTv:(UITableView *)tv dict:(NSDictionary *)dict;

@end
