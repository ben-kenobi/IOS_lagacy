//
//  YFTg.h
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTg : NSObject

@property (nonatomic,copy) NSString *buyCount;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *title;


+(instancetype)tgWithDict:(NSDictionary *)dict;
@end
