//
//  YFAppAdap.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAppAdap.h"

#import "YFApp.h"
#import "YFAppCell.h"

@implementation YFAppAdap

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFAppCell cellWithTv:tableView andMod:_datas[indexPath.row]];
}

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    return [[self alloc] initWithDatas:datas tv:tv];
}
-(instancetype)initWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    if(self=[super init]){
        _datas=[NSMutableArray array];
        self.tv=tv;
        self.tv.delegate=self;
        self.tv.dataSource=self;
        [self addToDatas:datas];
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)addToDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        [_datas addObject:[YFApp appWithDict:dict] ];
    }
    
}

@end
