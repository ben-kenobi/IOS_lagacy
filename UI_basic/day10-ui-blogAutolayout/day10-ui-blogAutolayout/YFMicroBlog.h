//
//  YFMicroBlog.h
//  day07-ui-microBlog
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFMicroBlog : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign,getter=isVip)BOOL vip;
+(instancetype)blogWithDict:(NSDictionary *)dict;

@end
