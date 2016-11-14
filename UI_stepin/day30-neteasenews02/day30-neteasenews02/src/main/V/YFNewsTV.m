//
//  YFNewsTV.m
//  ;
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsTV.h"
#import "YFNewsTVCell.h"
#import "YFNews.h"
#import "YFChannel.h"
@interface YFNewsTV ()
@property (nonatomic,assign)int page;
@property (nonatomic,assign)int len;
@property (nonatomic,strong)UIActivityIndicatorView *roll;
@end

@implementation YFNewsTV


-(void)initUI{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setSeparatorStyle:0];
    self.delegate=self;
    self.dataSource=self;
    self.rowHeight=80;
    
    self.roll=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_roll setHidesWhenStopped:YES];
    [_roll setColor:[UIColor orangeColor]];
    [self addSubview:_roll];
    [_roll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>_page*_len-_len){
        [self loadMore];
    }
    return [YFNewsTVCell cellWithTv:tableView news:self.datas[indexPath.row]];
}

-(void)appendDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        [self.datas addObject:[YFNews setDict:dict]];
    }
    [self reloadData];
}

-(void)setChan:(YFChannel *)chan{
    _page=0;
    _len=10;
    [self.datas removeAllObjects];
    [self reloadData];
    _chan=chan;
    [self loadMore];
    [self.roll startAnimating];
}

-(void)loadMore{
    [iApp setNetworkActivityIndicatorVisible:YES];
    NSString *url=[NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/%d-%d.html",self.chan.tid,_page*_len,_len];
    _page++;
    [IUtil get:iURL(url) cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
           
            [self appendDatas:[dict allValues][0] ];
        }else{
            _page--;
        }
        [self.roll stopAnimating];
        [iApp setNetworkActivityIndicatorVisible:NO];
    }];
}

@end
