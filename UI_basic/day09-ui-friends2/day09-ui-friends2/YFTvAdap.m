//
//  YFTvAdap.m
//  day09-ui-friends2
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTvAdap.h"
#import "YFFris.h"
#import "YFFri.h"
#import "UITableViewCell+Extension.h"
#import "YFHFv.h"

@interface YFTvAdap()<YFHFvDelegate>
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSIndexPath *focus;
@end


@implementation YFTvAdap

-(void)onBtnClicked:(YFHFv *)hfv{
    NSInteger section=hfv.tag;
    [self.tv reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YFFris *fris=_datas[section];
    return fris.open?fris.friends.count:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFFris *fris=_datas[indexPath.section];
    UITableViewCell *cell= [UITableViewCell cellWithTv:tableView andFri:fris.friends[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.focus isEqual:indexPath]){
        self.focus=nil;
    }else{
        if(self.focus&&[[_datas[self.focus.section] valueForKey:@"open"] boolValue])
            [self.tv reloadRowsAtIndexPaths:@[self.focus] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.focus=indexPath;
    }
    [self.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YFHFv *hfv= [YFHFv viewWithTableView:tableView andFris:_datas[section] delegate:self];
    hfv.tag=section;
    return hfv;
}

-(void)addToDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        [_datas addObject:[YFFris frisWithDict:dict]];
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [indexPath isEqual:_focus]?120:60;
}

-(instancetype)initWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    if(self=[super init]){
        self.tv=tv;
        tv.delegate=self;
        tv.dataSource=self;
        _datas=[NSMutableArray array];
        [self addToDatas:datas];
    }
    return self;
}

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    return [[self alloc] initWithDatas:datas tv:tv];
}

@end
