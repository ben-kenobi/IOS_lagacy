//
//  TFDeal.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "TFDeal.h"
#import "YFBusiness.h"
#import "MJExtension.h"

@implementation TFDeal
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}

- (NSDictionary *)objectClassInArray
{
    return @{@"businesses" : [YFBusiness class]};
}

- (BOOL)isEqual:(TFDeal *)other
{
    return [self.deal_id isEqual:other.deal_id];
}

MJCodingImplementation
@end
