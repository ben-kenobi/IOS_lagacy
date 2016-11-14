//
//  YFBlogCell.h
//  day10-ui-blogAutolayout
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFMicroBlog;

@interface YFBlogCell : UITableViewCell

@property (nonatomic,strong)YFMicroBlog *blog;


+(instancetype)cellWithTv:(UITableView *)tv blog:(YFMicroBlog *)blog;
@end
