//
//  YFContact.h
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFContact : NSObject <NSCoding>

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *num;
+(instancetype)conWithDict:(NSDictionary *)dict;

@end
