//
//  YFTvAdapter.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTvAdapter.h"
#import "YFTg.h"
#import "YFTgF.h"
#import "YFTgCell.h"
#import "YFHeaderFooterView.h"

#define HeaderH 50

@interface YFTvAdapter ()<UIAlertViewDelegate>
@property (nonatomic,weak) YFHeaderFooterView *hfv;
@end

@implementation YFTvAdapter


-(NSInteger)loadMore:(NSArray *)data{
    NSInteger from=_datas.count;
    [self appendDatas:data];
    NSInteger to=_datas.count;
    NSMutableArray *idxs=[NSMutableArray array];
    
    for(NSInteger i=from;i<to;i++){
        [idxs addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [_tv insertRowsAtIndexPaths:idxs withRowAnimation:UITableViewRowAnimationAutomatic];
    return _datas.count-1;
}






#pragma mark-  delegateMethod


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.tv deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else if(editingStyle==UITableViewCellEditingStyleInsert){
        
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"new name and price" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        av.tag=20;
        [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [av textFieldAtIndex:0].placeholder=@"name";
        [av textFieldAtIndex:1].placeholder=@"price";
        [[av textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeDecimalPad];
        [[av textFieldAtIndex:1] setSecureTextEntry:NO];
        [av textFieldAtIndex:0].tag=indexPath.row;
        [av show];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _hfv.style;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeaderH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *hfviden=@"tghfviden";
    YFHeaderFooterView *hfv=[tableView dequeueReusableHeaderFooterViewWithIdentifier:hfviden];
    if(nil==hfv){
        hfv=[[YFHeaderFooterView alloc] initWithReuseIdentifier:hfviden tv:tableView andH:HeaderH];
        self.hfv=hfv;
    }
    return hfv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"tgIden";
    YFTgCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[YFTgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell setTgf:_datas[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFTgF *f=_datas[indexPath.row];
    return f.height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"input newname" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
    [av setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [av textFieldAtIndex:0].text=[_datas[indexPath.row] valueForKeyPath:@"tg.title"];
    av.tag=10;
    [av textFieldAtIndex:0].tag=indexPath.row;
    [av show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0) return;
    NSInteger tag=alertView.tag;
    if(tag==10){
        NSString *str=[alertView textFieldAtIndex:0].text;
        NSInteger index=[alertView textFieldAtIndex:0].tag;
        [_datas[index] setValue:str forKeyPath:@"tg.title"];
        [_tv reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }else if(tag==20){
        NSString *str=[alertView textFieldAtIndex:0].text;
        NSInteger index=[alertView textFieldAtIndex:0].tag ;
        NSString *price=[alertView textFieldAtIndex:1].text;
        YFTgF *tgf=_datas[index];
        YFTg *newtg=[tgf.tg copy];
        newtg.title=str;
        newtg.price=price;
        newtg.buyCount=@"0";
        YFTgF *newtgf=[YFTgF tgfWithTg:newtg wid:tgf.wid];
        [_datas insertObject:newtgf atIndex:index];
        [self.tv insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        
    }
}



+(instancetype)adapterWithDatas:(NSArray *)datas andTv:(UITableView *)tv{
    return [[self alloc] initWithDatas:datas andTv:tv];
}

-(instancetype)initWithDatas:(NSArray *)datas andTv:(UITableView *)tv{
    if(self=[super init]){
        self.tv=tv;
        self.datas=[NSMutableArray array];
        [self appendDatas:datas];
    }
    return self;
}

-(void)appendDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        [_datas addObject:[YFTgF tgfWithTg:[YFTg tgWithDict:dict] wid:_tv.frame.size.width]];
    }
}



@end
