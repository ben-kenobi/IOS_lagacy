//
//  YFCarMod.h
//  day06-ui-showcars
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCarMod : NSObject
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;

+(instancetype)modWithDict:(NSDictionary*)dict;

@end
