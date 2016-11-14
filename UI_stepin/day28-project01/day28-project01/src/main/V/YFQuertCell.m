//
//  YFQuertCell.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFQuertCell.h"

@interface YFQuertCell ()
@property (nonatomic,weak)UILabel *title;
@property (nonatomic,weak)UILabel *subL;
@property (nonatomic,weak)UILabel *subR;

@end

@implementation YFQuertCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
//        [self setSelectionStyle:0];
        [self initUI];
    }
    return self;
}


+(instancetype)cellWithTV:(UITableView *)tv dict:(NSDictionary *)dict{
    static NSString *iden=@"celliden";
    YFQuertCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell= [[self alloc] initWithStyle:0 reuseIdentifier:iden];
    }
    
    [cell setDict:dict];
    
    return cell;
}

-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}
-(void)updateUI{
    self.title.text=_dict[@"title"];
    self.subL.text=[NSString stringWithFormat:@"创建时间:%@",_dict[@"date"]];
    self.subR.text=[NSString stringWithFormat:@"创建人:%@",_dict[@"name"]];
}


-(void)initUI{
    UILabel *(^newLab)(UIView *,UIFont *)=^(UIView *sup,UIFont *fo){
        UILabel *lab=[[UILabel alloc] init];
        [sup addSubview:lab];
        [lab setFont:fo];
        [lab setTextColor:[UIColor colorWithRed:.4 green:.4 blue:.55 alpha:1]];
        return lab;
    };
    
    self.title=newLab(self.contentView,[UIFont systemFontOfSize:17]);
    self.subL=newLab(self.contentView,[UIFont systemFontOfSize:12]);
    self.subR=newLab(self.contentView,[UIFont systemFontOfSize:12]);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@12);
        make.top.equalTo(@7);
    }];
    [self.subL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@12);
        make.bottom.equalTo(@-7);
    }];
    [self.subR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.bottom.equalTo(@-7);
    }];
    UIView *botline=[[UIView alloc] init];
    [botline setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:botline];
    [botline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@.7);
    }];
    
    
    
}

@end
