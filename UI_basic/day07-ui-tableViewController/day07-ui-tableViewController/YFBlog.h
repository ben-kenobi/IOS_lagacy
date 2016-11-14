//
//  YFBlog.h
//  day07-ui-tableViewController
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBlog : NSObject

@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *picture;
@property (nonatomic,assign,getter=isVip)BOOL vip;

+(instancetype)blogWithDict:(NSDictionary *)dict;

@end
