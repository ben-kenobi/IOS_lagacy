//
//  YFQuertCell.h
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFQuertCell : UITableViewCell
+(instancetype)cellWithTV:(UITableView *)tv dict:(NSDictionary *)dict;
@property (nonatomic,strong)NSDictionary *dict;

@end
