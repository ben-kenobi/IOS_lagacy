//
//  YFHFv.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHFv.h"
#import "Masonry.h"
#import "YFCate.h"

@interface YFHFv ()
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UILabel *lab;
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,assign)NSInteger section;
@property (nonatomic,weak)UIButton *add;
@property (nonatomic,weak)UIButton *del;

@end

@implementation YFHFv


+(instancetype)vWithTv:(UITableView *)tv cate:(YFCate *)cate section:(NSInteger)section{
    static NSString *iden=@"listhfviden";
    YFHFv *hfv=[tv dequeueReusableHeaderFooterViewWithIdentifier:iden];
    if(!hfv){
        hfv=[[self alloc] initWithReuseIdentifier:iden];
        hfv.tv=tv;
    }
    [hfv setCate:cate];
    [hfv setSection:section];
    return hfv;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super init]){
        [self initUI];
    }
    return self;
}

-(void)setCate:(YFCate *)cate{
    _cate=cate;
    [self updateUI];
}


-(void)updateUI{
    self.lab.text=[NSString stringWithFormat:@"%ld",[_cate.apps count]];
    [self.btn setTitle:_cate.name forState:UIControlStateNormal];
    self.btn.imageView.transform=CGAffineTransformMakeRotation(_cate.show?M_PI_2:0);
}


-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.btn){
        _cate.show=!_cate.show;
        [_tv reloadSections:[NSIndexSet indexSetWithIndex:_section] withRowAnimation:0];
    }else if(sender==self.add){
        if(self.addBlock)
            self.addBlock(_section);
    }else if(sender==self.del){
        if(self.delBlock)
            self.delBlock(_section);
    }
}

-(void)initUI{

    
    UIButton *btn=[[UIButton alloc] init];
    self.btn=btn;
    [self addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentEdgeInsets:(UIEdgeInsets){0,15,0,0}];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:(UIEdgeInsets){0,15,0,0}];
    [btn.imageView setContentMode:UIViewContentModeCenter];
    [btn.imageView.layer setMasksToBounds:NO];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(@0);
    }];
    
    
    UILabel *lab=[[UILabel alloc] init];
    self.lab=lab;
    [lab setTextAlignment:NSTextAlignmentRight];
    [lab setTextColor:[UIColor grayColor]];
    [lab setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@-10);
    }];
    
   
    UIButton *add=[[UIButton alloc] init];
    UIButton *del=[[UIButton alloc] init];
    self.add=add,self.del=del;
    [self addSubview:add],[self addSubview:del];
    [add setBackgroundColor:[UIColor colorWithRed:.5 green:.8 blue:.6 alpha:1]];
    [add setTitle:@"+" forState:UIControlStateNormal];
    [add titleLabel].font=[UIFont boldSystemFontOfSize:33];
    [add setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [del setBackgroundColor:[UIColor colorWithRed:.8 green:.5 blue:.6 alpha:1]];
    [del setTitle:@"-" forState:UIControlStateNormal];
    [del titleLabel].font=[UIFont boldSystemFontOfSize:33];
    [del setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-80);
        make.top.equalTo(@1);
        make.width.height.equalTo(self.mas_height).multipliedBy(.95);
    }];
    
    [del mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(add.mas_left).offset(-10);
        make.top.equalTo(@1);
        make.width.height.equalTo(self.mas_height).multipliedBy(.95);
    }];

    [self.add addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.del addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

@end
