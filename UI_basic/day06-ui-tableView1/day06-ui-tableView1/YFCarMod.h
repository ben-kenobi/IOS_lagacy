//
//  YFCarMod.h
//  day06-ui-tableView1
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCarMod : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSArray *cars;

+(instancetype)modWithDict:(NSDictionary *)dict;

@end
