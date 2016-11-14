//
//  YFCity.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCity.h"
#import "YFRegion.h"
@implementation YFCity

- (NSDictionary *)objectClassInArray
{
    return @{@"regions" : [YFRegion class]};
}
-(NSString *)description{
    return [NSString stringWithFormat:@"{name=%@,regions=%@}",_name,_regions];
}
@end
