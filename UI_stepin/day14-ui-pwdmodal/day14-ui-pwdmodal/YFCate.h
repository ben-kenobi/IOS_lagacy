//
//  YFCate.h
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFCate : NSObject<NSCoding>

@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)NSMutableArray  *apps;
@property (nonatomic,assign)BOOL show;

+(instancetype)cateWithDict:(NSDictionary *)dict;

@end
