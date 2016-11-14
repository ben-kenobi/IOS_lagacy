//
//  YFFriendList.h
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFFriendList : NSObject
@property (nonatomic,copy)NSArray *friends;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger online;
@property (nonatomic,assign,getter=isHide)BOOL hide;

+(instancetype)listWithDict:(NSDictionary *)dict;


@end
