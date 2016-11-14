//
//  YFBlogF.h
//  day07-ui-tableViewController
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@class YFBlog;

@interface YFBlogF : NSObject

@property (nonatomic,assign,readonly)CGRect textF;
@property (nonatomic,assign,readonly)CGRect iconF;
@property (nonatomic,assign,readonly)CGRect nameF;
@property (nonatomic,assign,readonly)CGRect vipF;
@property (nonatomic,assign,readonly)CGRect picF;
@property (nonatomic,assign,readonly)CGFloat height;
@property (nonatomic,strong)YFBlog *blog;
@property (nonatomic,assign)CGFloat wid;

+(instancetype)blogFWithBlog:(YFBlog *)blog wid:(CGFloat)wid;

@end
