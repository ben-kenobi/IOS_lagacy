//
//  YFRegion.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFRegion.h"

@implementation YFRegion
-(NSString *)description{
    return [NSString stringWithFormat:@"{name=%@,subregions=%@}",_name,_subregions];
}
@end
