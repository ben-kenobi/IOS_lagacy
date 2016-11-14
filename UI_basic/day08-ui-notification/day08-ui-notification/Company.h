//
//  Company.h
//  day08-ui-notification
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
@property (nonatomic,copy)NSString *name;
+(instancetype)comWithName:(NSString *)name;
@end
