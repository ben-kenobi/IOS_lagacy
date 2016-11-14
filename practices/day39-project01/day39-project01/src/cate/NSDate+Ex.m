//
//  NSDate+Ex.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSDate+Ex.h"

@implementation NSDate (Ex)


-(NSString *)dateFormat{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd";
    }
    return [fm stringFromDate:self];
    
}
-(NSString *)timeFormat{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    }
    return [fm stringFromDate:self];
}

+(instancetype)dateFromStr:(NSString *)str{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd";
    }
    return [fm dateFromString:str];
}
+(instancetype)timeFromStr:(NSString *)str{
    static  NSDateFormatter *fm;
    if(!fm){
        fm=[[NSDateFormatter alloc] init];
        fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    }
    return [fm dateFromString:str];
}

@end
