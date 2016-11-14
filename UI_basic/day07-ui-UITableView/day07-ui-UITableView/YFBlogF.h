//
//  YFBlogF.h
//  day07-ui-UITableView
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFBlog;

@interface YFBlogF : NSObject

@property (nonatomic,assign) CGRect picF;
@property (nonatomic,assign) CGRect textF;
@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect vipF;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat wid;
@property (nonatomic,strong) YFBlog *blog;

+(instancetype)blogFWithblog:(YFBlog *)blog wid:(CGFloat)wid;

@end
