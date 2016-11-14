//
//  NSArray+Ex.m
//  day27-network
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "NSArray+Ex.h"

@implementation NSArray (Ex)

-(NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *mstr=[NSMutableString string];
    [mstr appendString:@"(\t"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mstr appendFormat:@"\n\t%@,",obj];
    }];
    
    [mstr appendString:@"\n)\n"];
    return mstr;
}

@end

@implementation NSDictionary (Ex)
-(NSString *)descriptionWithLocale:(id)locale{
     NSMutableString *mstr=[NSMutableString string];
    [mstr appendString:@"{\t"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mstr appendFormat:@"\n\t%@ = %@;",key,obj];
    }];
    
    [mstr appendString:@"\n}\n"];
    
    return mstr;
}
@end
