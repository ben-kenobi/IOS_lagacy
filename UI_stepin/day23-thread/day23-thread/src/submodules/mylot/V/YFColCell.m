//
//  YFColCell.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFColCell.h"

@interface YFColCell ()
@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,weak)UILabel *lab;

@end

@implementation YFColCell


-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}

-(void)updateUI{
    self.iv.image=[UIImage imageNamed:_dict[@"icon"]];
    self.lab.text=_dict[@"title"];
}
-(void)initUI{
    UIImageView *iv=[[UIImageView alloc] init];
    [self addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(@0);
        make.height.width.equalTo(@60);
    }];
    iv.layer.cornerRadius=10;
    iv.layer.masksToBounds=YES;
    
    
    UILabel *lab=[[UILabel alloc] init];
    [lab setTextColor:[UIColor grayColor]];
    self.lab=lab;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(@0);
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

@end
