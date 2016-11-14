//
//  NSDate+Ex.h
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Ex)

-(NSString *)dateFormat;
-(NSString *)timeFormat;

+(instancetype)dateFromStr:(NSString *)str;
+(instancetype)timeFromStr:(NSString *)str;
@end
