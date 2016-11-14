//
//  YFFri.h
//  day09-ui-friends2
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFFri : NSObject

@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *intro;
@property (nonatomic,assign)BOOL vip;

+(instancetype)friWithDict:(NSDictionary *)dict;

@end
