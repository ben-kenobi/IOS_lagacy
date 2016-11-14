//
//  YFBLogCell.h
//  day07-ui-microBlog
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFBlogF;


@interface YFBLogCell : UITableViewCell

@property (nonatomic, weak) UIImageView *pic;
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *text;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UIImageView *vip;
@property (nonatomic,strong) YFBlogF *blogF;

@end
