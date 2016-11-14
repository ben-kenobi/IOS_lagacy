//
//  YFTvAdapter.m
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTvAdapter.h"
#import "YFTg.h"
#import "YFTgCellTableViewCell.h"

@interface YFTvAdapter ()
@property (nonatomic,strong)UIScrollView *header;

@end

@implementation YFTvAdapter






- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return  @"";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.header==nil){
        self.header=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
    }
    return _header;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"tgiden";
    YFTgCellTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell)
        cell=[[NSBundle mainBundle] loadNibNamed:@"YFTgCell" owner:nil options:nil][0];
    
    YFTg *tg=self.data[indexPath.row];
    [cell setTg:tg];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    return cell;
}






-(void)appendData:(NSArray *)datas{
    NSInteger from=self.data.count;
    NSMutableArray *mary=[NSMutableArray array];
    for(NSDictionary *dict in datas){
        [mary addObject:[YFTg tgWithDict:dict]];
    }
    [self.data addObjectsFromArray:mary];
    NSMutableArray *idxs=[NSMutableArray array];
    for(NSInteger i=from;i<self.data.count;i++){
        [idxs addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    
    [self.tv insertRowsAtIndexPaths:idxs withRowAnimation:UITableViewRowAnimationBottom ];
}



-(instancetype)initWithData:(NSArray *)data tableView:(UITableView *)tv{
    if(self=[super init]){
        self.tv=tv;
        self.data=[NSMutableArray array];
        for(NSDictionary *dict in data){
            [self.data addObject:[YFTg tgWithDict:dict]];
        }
    }
    
    return self;
}

+(instancetype)adapterWithData:(NSArray *)data tableView:(UITableView *)tv{
    return [[self alloc] initWithData:data tableView:tv];
}



@end
