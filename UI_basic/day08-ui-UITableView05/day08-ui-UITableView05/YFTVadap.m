//
//  YFTVadap.m
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTVadap.h"
#import "YFChatF.h"
#import "YFChatMod.h"
#import "YFChatCell.h"

@interface YFTVadap ()
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,weak)UITableView *tv;



@end

@implementation YFTVadap



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.tv.superview endEditing:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFChatF *f=_datas[indexPath.row];
    return f.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"chariden";
    YFChatCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[YFChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor] ];
    }
    [cell setChaf:_datas[indexPath.row]];
    
    return cell;
}

+(instancetype)adapWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    return [[self alloc] initWithDatas:datas tv:tv];
}

-(instancetype)initWithDatas:(NSArray *)datas tv:(UITableView *)tv{
    if(self=[super init]){
        _datas=[NSMutableArray array];
        self.tv=tv;
        [self appendDatas:datas];
    }
    return self;
}

-(void)appendDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        YFChatMod *mod=[YFChatMod modWithDict:dict];
        YFChatMod *lastmod=[[_datas lastObject] valueForKeyPath:@"mod"];
        mod.hideTime=[lastmod.time isEqualToString:mod.time];
        
       [_datas addObject:[YFChatF charFWithMod:mod wid:self.tv.frame.size.width]];
    }
}


-(void)addDatas:(NSArray *)datas{
    NSInteger from=_datas.count;
    [self appendDatas:datas];
    NSInteger to=_datas.count;
    NSMutableArray *mary=[NSMutableArray array];
    for(NSInteger i=from;i<to;i++){
        [mary addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self.tv insertRowsAtIndexPaths:mary withRowAnimation:UITableViewRowAnimationTop];
    [self.tv scrollToRowAtIndexPath:mary.lastObject atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}


@end
