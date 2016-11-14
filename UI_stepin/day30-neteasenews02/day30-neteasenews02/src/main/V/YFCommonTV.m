//
//  YFCommonTV.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCommonTV.h"

@implementation YFCommonTV



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

iLazy4Ary(datas, _datas)
@end
