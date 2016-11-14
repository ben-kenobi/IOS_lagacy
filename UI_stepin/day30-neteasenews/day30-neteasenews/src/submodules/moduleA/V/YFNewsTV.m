//
//  YFNewsTV.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsTV.h"
#import "YFChannel.h"
#import "YFNews.h"
#import "YFNewsTVCell.h"

static NSString *const celliden=@"newstvcelliden";

@interface YFNewsTV ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)UIActivityIndicatorView *roll;
@property (nonatomic,assign)int page;
@property(nonatomic,assign) int pagelen;

@end

@implementation YFNewsTV



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self=[super initWithFrame:frame style:style]){
        self.delegate=self;
        self.dataSource=self;
        self.rowHeight=80;
        [self setSeparatorStyle:0];
        self.roll=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

        [self.roll setColor:[UIColor orangeColor]];

        [self addSubview:self.roll];
        self.roll.center=self.innerCenter;
        [self.roll setHidesWhenStopped:YES];
        [self registerClass:[YFNewsTVCell class] forCellReuseIdentifier:celliden];

    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFNewsTVCell *cell=[tableView dequeueReusableCellWithIdentifier:celliden];
    [cell setNews:self.datas[indexPath.row]];
    if(indexPath.row>_pagelen*_page-_pagelen){
        [self loadMore];
    }
    return cell;
}

-(void)setChan:(YFChannel *)chan{
    _pagelen=10;
    _page=0;
    _chan=chan;
    [self.datas removeAllObjects];
    [self reloadData];
    [self loadMore];
}
-(void)loadMore{
    if(!_page)
    [self.roll startAnimating];
    _page++;
    NSString *str = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/%d-%d.html",_chan.tid,(_page-1)*_pagelen,_pagelen];
    [IUtil get:iURL(str) cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self.roll stopAnimating];
        self.roll.hidden=YES;
        if(data&&!error){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
        
            [self appendDatas:[dict allValues][0]];
        }else{
            _page--;
             NSLog(@"%@",error);
        }
        
    }];
    

}




-(void)appendDatas:(NSArray *)ary{
    for(NSDictionary *dict in ary){
        [self.datas addObject:[YFNews setDict:dict]];
    }
    [self reloadData];
}


iLazy4Ary(datas, _datas)

@end
