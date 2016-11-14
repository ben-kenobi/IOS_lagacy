//
//  YFFocus.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "JSONModel.h"
/**
 *      "id": 焦点图ID,
 "title": 焦点图标题,
 "cover":  图片链接",
 "link": 所要跳转的基础连接（例如：http://www.qd-life.com/）,
 "res_name":  跳转到指定的模块,
 "res_id": 指定模块下的详情ID
 */
@interface YFFocus : JSONModel
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *cover;
@property (nonatomic,copy)NSString *link;
@property (nonatomic,copy)NSString *res_id;
@property (nonatomic,copy)NSString *res_name;
@property (nonatomic,assign)int id;
@end
