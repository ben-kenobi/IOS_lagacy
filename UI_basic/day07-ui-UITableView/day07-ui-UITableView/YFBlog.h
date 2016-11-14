//
//  YFBlog.h
//  day07-ui-UITableView
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFBlog : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,assign,getter=isVIp) BOOL vip;


+(instancetype)blogWithDict:(NSDictionary *)dict;
@end
