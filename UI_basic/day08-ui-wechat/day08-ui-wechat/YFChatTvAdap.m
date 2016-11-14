//
//  YFChatTvAdap.m
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFChatTvAdap.h"
#import "YFWechatMod.h"
#import "YFWechatF.h"
#import "YFWechatCell.h"


@interface YFChatTvAdap ()
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,weak)UITableView *tv;

@end

@implementation YFChatTvAdap



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.tv.superview endEditing:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFWechatF *f=_datas[indexPath.row];
    return f.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"chatiden";
    YFWechatCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[YFWechatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    [cell setF:_datas[indexPath.row]];
    return cell;
}




+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    return [[self alloc] initWithDatas:datas tv:tv];
}

-(instancetype)initWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    if(self=[super init]){
        self.tv=tv;
        tv.delegate=self;
        tv.dataSource=self;
        _datas=[NSMutableArray array];
        [self appendDatas:datas];
    }
    return self;
}

-(void)addDatas:(NSArray *)datas{
    NSInteger from =_datas.count;
    [self appendDatas:datas];
    NSInteger to=_datas.count;
    NSMutableArray *mary=[NSMutableArray array];
    for(NSInteger i=from;i<to;i++)
        [mary addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    [self.tv insertRowsAtIndexPaths:mary withRowAnimation:UITableViewRowAnimationTop];
    [self.tv scrollToRowAtIndexPath:[mary lastObject] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

-(void) appendDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        NSString *lasttime=[[_datas lastObject] valueForKeyPath:@"mod.time"];
        [_datas addObject:[YFWechatF fWithMod:[YFWechatMod modWithDict:dict lastTime:lasttime]]];
    }
}




@end
