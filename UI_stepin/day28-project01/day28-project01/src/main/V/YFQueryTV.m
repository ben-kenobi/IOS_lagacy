//
//  YFQueryTV.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFQueryTV.h"
#import "YFQuertCell.h"
#import "YFDetailVC.h"


@interface YFQueryTV ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation YFQueryTV
@synthesize datas=_datas;

-(void)setDatas:(NSMutableArray *)datas{
    _datas=datas;

    dispatch_sync(dispatch_get_main_queue(), ^{

        [self reloadData];
    });
}
-(instancetype)init{
    if(self=[super init]){
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFQuertCell cellWithTV:tableView dict:_datas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFDetailVC *vc=[[YFDetailVC alloc] init];
    vc.title=@"单据详情";
    vc.dict=self.datas[indexPath.row];
    [UIViewController pushVC:vc];
}

iLazy4Ary(datas, _datas)
@end
