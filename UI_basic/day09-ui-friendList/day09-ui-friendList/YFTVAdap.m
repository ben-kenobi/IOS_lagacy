//
//  YFTVAdap.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTVAdap.h"
#import "YFFriendF.h"
#import "YFFriendList.h"
#import "YFFriend.h"
#import "YFFriListF.h"
#import "YFFriCell.h"
#import "YFHFView.h"

@interface YFTVAdap ()<YFHFViewDelegate>
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,strong)NSMutableArray *datas;
@end


@implementation YFTVAdap


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YFFriListF *f=_datas[section];
    return f.frilist.isHide?0: f.frilist.friends.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFFriListF *f=_datas[indexPath.section];
    YFFriendF *ff=f.frilist.friends[indexPath.row];
    return ff.heigth;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFFriListF *listf=_datas[indexPath.section];
    return [YFFriCell cellWithTv:tableView andFriF:listf.frilist.friends[indexPath.row]];
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YFHFView *hfv=[YFHFView viewWithTv:tableView andListF:_datas[section] andDelegate:self];
    hfv.tag=section;
    return hfv;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    YFFriListF *f=_datas[section];
    return f.height;
}


-(void)toggleSection:(YFHFView *)hfv{
    NSInteger section=hfv.tag;
    
  [self.tv reloadSections:[NSIndexSet indexSetWithIndex:section]  withRowAnimation:UITableViewRowAnimationFade];
}


+(instancetype)adapWithDatas:(NSArray *)ary tv:(UITableView *)tv{
    return [[self alloc] initWithDatas:ary tv:tv];
}
-(instancetype)initWithDatas:(NSArray *)ary tv:(UITableView *)tv{
    if(self=[super init]){
        self.datas=[NSMutableArray array];
        self.tv=tv;
        tv.delegate=self;
        tv.dataSource=self;
        [self addToDatas:ary];
    }
    return self;
}

-(void)addToDatas:(NSArray *)ary{
    for(NSDictionary *dict in ary){
        [_datas addObject:[YFFriListF fWithFrilist:[YFFriendList listWithDict:dict]] ];
    }
    
    int i,j,k;
    YFFriendF *temp;
    for(k=0;k<_datas.count;k++){
        YFFriListF * f=_datas[k];
        for(i=1;i<f.frilist.friends.count;i++){
            temp=f.frilist.friends[i];
            for(j=i-1;j>=0&&temp.fri.isVip>[[f.frilist.friends[j] valueForKeyPath:@"fri.vip"] boolValue];j--){
                
                [f.frilist.friends replaceObjectAtIndex:j+1 withObject:f.frilist.friends[j]];
            }
            [f.frilist.friends replaceObjectAtIndex:j+1 withObject:temp];
        }
        
        
        
    }
}

@end
