//
//  YFTable.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTable.h"
#import "YFTableCell.h"
#import "YFTableCellF.h"
#import "YFConfirmVC.h"

@interface YFTable ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UIButton *con;

@end

@implementation YFTable
@synthesize datas=_datas;
@synthesize infos=_infos;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFTableCell cellWithTv:tableView dict:self.datas[indexPath.row] idxed:NO];
}

-(instancetype)init{
    if(self =[super init]){
        self.delegate=self;
        self.dataSource=self;
        [self initUI];
    }
    return  self;
}

-(void)initUI{
    UIColor *tcolor=[UIColor colorWithRed:.4 green:.4 blue:.55 alpha:1];
    UIView *header=[[UIView alloc] initWithFrame:(CGRect){0,0,0,35}];
    UILabel *lab=[[UILabel alloc] init];
    [header addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.centerY.equalTo(@0);
    }];
    [lab setTextColor:tcolor];
    lab.text=@"抬头信息";
    [self setTableHeaderView:header];
    
   
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFTableCellF *f=self.datas[indexPath.row];
    return f.height;
}
-(void)setDatas:(NSMutableArray *)datas{
    for(NSDictionary *dict in datas){
        YFTableCellF *f=[YFTableCellF fWithDict:dict];
        [self.datas addObject:f];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });

}

-(void)setInfos:(NSMutableArray *)infos{
    for(NSDictionary *dict in infos){
        YFTableCellF *f=[YFTableCellF fWithDict:dict];
        [self.infos addObject:f];
    }
   YFTableCellF *f= self.infos[0];
     UIView *footer=[[UIView alloc] initWithFrame:(CGRect){0,0,iScreenW,f.height*6}];

    
    YFTableCell *cell1=[YFTableCell cellWithTv:0 dict:self.infos[0] idxed:YES];
    YFTableCell *cell2=[YFTableCell cellWithTv:0 dict:self.infos[1] idxed:YES];

    cell1.frame=(CGRect){0,0,iScreenW,f.height};
    cell2.frame=(CGRect){0,f.height,iScreenW,f.height};
    [cell1 setBackgroundColor:[UIColor clearColor]];
    [cell2 setBackgroundColor:[UIColor clearColor]];
    [footer addSubview:cell1];
    [footer addSubview:cell2];
    
    if(self.confirm){
        UIButton *btn =[[UIButton alloc] init];
        [btn setImage:img(@"confirm") forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.cx=iScreenW*.5;
        btn.b=f.height*6;
        [footer addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.con=btn;
    }
    
    [footer setBackgroundColor:[UIColor whiteColor]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTableFooterView:footer];
    });
    
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.con){
        YFConfirmVC *vc=[[YFConfirmVC alloc] init];
        vc.title=@"确认签收";
        [UIViewController pushVC:vc];
    }
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self setDatas:_dict[@"抬头信息"]];
    [self setInfos:_dict[@"见证性材料"]];
}

iLazy4Ary(infos, _infos)
iLazy4Ary(datas, _datas)

@end
