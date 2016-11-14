//
//  YFWechatAdap.m
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWechatAdap.h"
#import "YFWechatMod.h"
#import "YFWechatF.h"
#import "YFWechatCell.h"

@implementation YFWechatAdap


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.tv.superview endEditing:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFWechatF *f=_datas[indexPath.row];
    return f.height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"wechatIden";
    YFWechatCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[YFWechatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    [cell setF:_datas[indexPath.row]];
    return cell;
}




-(instancetype)initWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    if(self=[super init]){
        _datas=[NSMutableArray array];
        self.tv=tv;
        tv.delegate=self;
        tv.dataSource=self;
        [self addTtoDatas:datas];
    }
    return self;
}

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    return [[self alloc] initWithDatas:datas tv:tv];
}


-(void)appendDatas:(NSArray *)ary{
    NSInteger from=_datas.count;
    [self addTtoDatas:ary];
    NSInteger to=_datas.count;
    NSMutableArray *mary=[NSMutableArray array];
    for(NSInteger i=from;i<to;i++){
        [mary addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self.tv insertRowsAtIndexPaths:mary withRowAnimation:UITableViewRowAnimationLeft];
    [self.tv scrollToRowAtIndexPath:[mary lastObject] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

-(void)addTtoDatas:(NSArray *)ary{
    for(NSDictionary *dict in ary){
        [_datas addObject:[YFWechatF fWithMod:[YFWechatMod modWithDict:dict lastTime:[[_datas lastObject] valueForKeyPath:@"mod.time"]]] ];
    }
}

@end
