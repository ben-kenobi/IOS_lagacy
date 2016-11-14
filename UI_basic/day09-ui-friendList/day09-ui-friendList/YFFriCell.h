//
//  YFFriCell.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFFriendF;
@interface YFFriCell : UITableViewCell



@property (nonatomic,strong)YFFriendF *friF;

+(instancetype)cellWithTv:(UITableView *)tv andFriF:(YFFriendF*)friF;

@end
