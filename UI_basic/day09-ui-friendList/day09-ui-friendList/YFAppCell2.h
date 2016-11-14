//
//  YFAppCell2.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFApp;

@interface YFAppCell2 : UITableViewCell

@property (nonatomic,strong)YFApp *mod;
+(instancetype)cellWithTv:(UITableView *)tv andMod:(YFApp *)mod;


@end
