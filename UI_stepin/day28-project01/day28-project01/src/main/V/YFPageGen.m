//
//  YFPageGen.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFPageGen.h"

@implementation YFPageGen
+(NSString *)genPageWith:(NSDictionary *)dict{
    NSMutableString *mstr=[NSMutableString string];
    
    for(NSString *key in dict.allKeys){
        [mstr appendFormat:@"<tr>%@</tr>",key];
        NSDictionary *dic=dict[key];
        for(NSString *key in dic.allKeys){
            [mstr appendFormat:@"<tr display='backgroundColor:#777';>%@:%@</tr>",key,dic[key]];
        }
        
    }
    
    
    
    
    return [NSString stringWithFormat: @"<html>"
    "<head lang='en'>"
    "<title></title>"
    "<meta charset='UTF-8'>"
    
    "</head>"
    
    "<body>"
    "<table >"
    "%@"
    "</table>"
    "</body>"
    
     "</html>",mstr ];
}



@end
