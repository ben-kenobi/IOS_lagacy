//
//  QFObjectARC.m
//  TestSetter
//
//  Created by qianfeng on 14-6-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "QFObjectARC.h"

@implementation QFObjectARC

-(void)setTag:(NSInteger)tag
{
    _tag = tag;
}

-(void)setMutableStr:(NSMutableString *)mutableStr
{
    _mutableStr = mutableStr;
}

-(void)dealloc
{
    _mutableStr = nil;
}

@end
