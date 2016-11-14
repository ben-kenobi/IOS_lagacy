//
//  YFHeroMod.h
//  day06-ui-tableView1
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFHeroMod : NSObject
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *name;
+(instancetype)modWithDict:(NSDictionary *)dict;
@end
