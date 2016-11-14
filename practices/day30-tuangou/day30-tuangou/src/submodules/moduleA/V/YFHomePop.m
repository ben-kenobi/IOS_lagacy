//
//  YFHomePop.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomePop.h"
#import "YFHomePopCell.h"
#import "YFHomePopSubCell.h"

@interface YFHomePop ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *maintv;
@property (nonatomic,strong)UITableView *subtv;
@property (nonatomic,assign)NSInteger selrow;
@end

@implementation YFHomePop

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.maintv=[[UITableView alloc] initWithFrame:(CGRect){0,0,self.w*.5,self.h} style:UITableViewStylePlain];
    self.subtv=[[UITableView alloc]initWithFrame:(CGRect){self.w*.5-.5,0,self.w*.5-.5,self.h} style:UITableViewStylePlain];
    [self addSubview:self.maintv];
    [self addSubview:self.subtv];
    self.maintv.delegate=self;
    self.maintv.dataSource=self;
    self.subtv.delegate=self;
    self.subtv.dataSource=self;
    [self.subtv setSeparatorStyle:0];
    [self.maintv setSeparatorStyle:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.maintv){
        return [self.delegate numberOfRows:self];
    }else{
        return [self.delegate pop:self subdataForRow:self.selrow].count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.maintv){
        YFHomePopCell *cell= [YFHomePopCell cellWithTv:tableView];
        [self.delegate pop:self updateCell:cell atRow:indexPath.row];
        return cell;
    }else{
        YFHomePopSubCell *cell= [YFHomePopSubCell cellWithTv:tableView];
        cell.textLabel.text=[self.delegate pop:self subdataForRow:self.selrow][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.maintv){
        self.selrow=indexPath.row;
        [self.subtv reloadData];
        [self.delegate pop:self didSelectRow:indexPath.row];
    }else{
        [self.delegate pop:self didSelectSubRow:indexPath.row row:self.selrow];
    }
}


@end
