//
//  YFTg.h
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTg : NSObject<NSCopying>

@property (nonatomic,copy)NSString *buyCount;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *icon;

+(instancetype)tgWithDict:(NSDictionary *)dict;


@end
