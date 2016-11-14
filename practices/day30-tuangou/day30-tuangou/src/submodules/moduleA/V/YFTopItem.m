
//
//  YFTopItem.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTopItem.h"
@interface YFTopItem ()

@end


@implementation YFTopItem

-(instancetype)init{
    if(self=[super initWithFrame:(CGRect){0,0,140,35}]){
        [self initUI];
    }
    return self;
}

-(void)onBtnClicked:(id)sender{
    if(self.onClick)
        self.onClick(sender);
}

-(void)initUI{
    self.title=[[UILabel alloc] init];
    self.subtitle=[[UILabel alloc] init];
    [self.title setFont:[UIFont systemFontOfSize:12]];
    [self.subtitle setFont:[UIFont systemFontOfSize:15]];
    self.btn=[[UIButton alloc] init];
    [self addSubview:self.title];
    [self addSubview:self.subtitle];
    [self addSubview:self.btn];
    [self.btn setImage:img(@"icon_district") forState:UIControlStateNormal];
    [self.btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.btn setContentEdgeInsets:(UIEdgeInsets){0,11,0,0}];
    UIView *v=[[UIView alloc] init];
    [v setBackgroundColor:[UIColor blackColor]];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(@6);
        make.bottom.equalTo(@-6);
        make.width.equalTo(@.7);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@40);
    }];
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.leading.equalTo(self.title);
    }];
    [self.btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

@end
