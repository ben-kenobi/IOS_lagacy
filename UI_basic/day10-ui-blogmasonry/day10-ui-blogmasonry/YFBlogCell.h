//
//  YFBlogCell.h
//  day10-ui-blogmasonry
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFBlog.h"

@interface YFBlogCell : UITableViewCell
@property (nonatomic,weak)UIImageView *icon;
@property (nonatomic,weak)UILabel *name;
@property (nonatomic,weak)UILabel *text;
@property (nonatomic,weak)UIImageView *vip;
@property (nonatomic,weak)UIImageView *pic;
@property (nonatomic,strong)YFBlog *blog;
+(instancetype)cellWithTv:(UITableView *)tv andBlog:(YFBlog *)blog;

@end
