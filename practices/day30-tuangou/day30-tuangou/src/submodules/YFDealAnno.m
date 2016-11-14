//
//  YFDealAnno.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDealAnno.h"

@implementation YFDealAnno
-(BOOL)isEqual:(YFDealAnno *)object{
    return [self.title isEqual:object.title];
}
@end
