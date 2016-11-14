//
//  YFBlogCell.h
//  day10-ui-blogautolayout2
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "YFBlog.h"

@interface YFBlogCell : UITableViewCell

@property (nonatomic,strong) YFBlog *blog;

+(instancetype)cellWithTv:(UITableView *)tv andMod:(YFBlog *)blog;

@end
