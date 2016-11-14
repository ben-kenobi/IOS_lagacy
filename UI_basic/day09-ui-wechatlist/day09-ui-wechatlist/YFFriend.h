//
//  YFFriend.h
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFFriend : NSObject
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign,getter=isVip) BOOL vip;
+(instancetype)friendWithDict:(NSDictionary *)dict;

@end
