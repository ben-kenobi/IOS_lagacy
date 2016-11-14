//
//  YFConfirmVC.m
//  day28-project01
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFConfirmVC.h"
#import "YFSelector.h"
#import "YFevaluator.h"
#import "YFTv.h"
@interface YFConfirmVC ()


@property (nonatomic,weak)UIScrollView *sv;
@property (nonatomic,weak)YFSelector *sel1;
@property (nonatomic,weak)YFSelector *sel2;
@property (nonatomic,weak)YFevaluator *eva;
@property (nonatomic,weak)UIView *contentv;
@property (nonatomic,weak)YFTv *tv;
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UIBarButtonItem *item;
@property (nonatomic,weak)UIImageView *iv01;
@property (nonatomic,weak)UIImageView *iv02;
@property (nonatomic,weak)UIView *view01;
@property (nonatomic,weak)UIView *view02;
@end


@implementation YFConfirmVC

-(void)loadView{
    self.view=[[UIScrollView alloc] init];
    self.sv=(UIScrollView *)self.view;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    UIView *content=[[UIView alloc] init];
    [self.sv addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.width.equalTo(@(iScreenW));
    }];
    self.contentv=content;
    
    UILabel *lab=[[UILabel alloc]init];
    lab.text=@"拍摄鉴证材料,请选择";
    [self.contentv addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.centerX.equalTo(@0);
    }];
    
    YFSelector *sel1=[[YFSelector alloc] init];
    [sel1 setTitle:@"签收单照片"];
    self.sel1=sel1;
    YFSelector *sel2=[[YFSelector alloc] init];
    self.sel2=sel2;
    [sel2 setTitle:@"快递单照片"];
    [sel1 setBackgroundColor:[UIColor clearColor]];
    [sel2 setBackgroundColor:[UIColor clearColor]];
    [self.contentv addSubview:sel1];
    [self.contentv addSubview:sel2];
    [sel1 setSelected:YES];
    [sel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(lab.mas_bottom).offset(30);
        make.height.equalTo(@30);
        make.width.equalTo(self.contentv.mas_width).offset(-150);
    }];
    [sel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(sel1.mas_bottom).offset(12);
        make.height.equalTo(@30);
        make.width.equalTo(self.contentv.mas_width).offset(-150);
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBtnClicked:)];
     UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBtnClicked:)];
    [sel1 addGestureRecognizer:tap];
    [sel2 addGestureRecognizer:tap2];
    
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(onBtnClicked:)];
    self.item=item;
    UIToolbar *tb=[[UIToolbar alloc] init];
    [self.contentv addSubview:tb];
    [tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@60);
        make.right.equalTo(@-30);
        make.top.equalTo(sel1.mas_top).offset(0);
    }];
    tb.items=@[item];
    [tb setTintColor:[UIColor colorWithRed:0.382 green:0.000 blue:1.000 alpha:1.000]];
    [tb setBarTintColor:[UIColor lightGrayColor]];
    tb.layer.cornerRadius=30;
    tb.layer.masksToBounds=YES;
    tb.layer.borderColor=[[UIColor colorWithRed:0.382 green:0.000 blue:1.000 alpha:1.000] CGColor];
    tb.layer.borderWidth=3;

    UIView *view01=[[UIView alloc] init];
    [self.contentv addSubview:view01];
    self.view01=view01;
    [view01 setBackgroundColor:[UIColor colorWithRed:0.794 green:0.945 blue:1.000 alpha:1.000]];
    [view01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sel2.mas_bottom).offset(30);
        make.right.left.equalTo(@0);
        make.height.equalTo(@0);
    }];
    UILabel *lab01=[[UILabel alloc] init];
    lab01.text=@"签收单照片";
    [view01 addSubview:lab01];
    [lab01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
    }];
    UIImageView *iv01=[[UIImageView alloc] init];
    self.iv01=iv01;
    [view01 addSubview:iv01];
    [iv01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab01.mas_bottom).offset(15);
        make.left.equalTo(@25);
        make.right.equalTo(@-25);
        make.height.equalTo(@140);
    }];
    
    
    
    
    UIView *view02=[[UIView alloc] init];
    [self.contentv addSubview:view02];
    self.view02=view02;
    [view02 setBackgroundColor:[UIColor colorWithRed:0.794 green:0.945 blue:1.000 alpha:1.000]];
    [view02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view01.mas_bottom).offset(10);
        make.right.left.equalTo(@0);
        make.height.equalTo(@0);
    }];
    
    UILabel *lab02=[[UILabel alloc] init];
    lab02.text=@"快递单照片";
    [view02 addSubview:lab02];
    [lab02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
    }];
    
    UIImageView *iv02=[[UIImageView alloc ] init];
    self.iv02=iv02;
    [view02 addSubview:iv02];
    [iv02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab02.mas_bottom).offset(15);
        make.left.equalTo(@25);
        make.right.equalTo(@-25);
        make.height.equalTo(@140);
    }];
    
    
    
    
    
    UIView *view=[[UIView alloc] init];
    [self.contentv addSubview:view];
    [view setBackgroundColor:[UIColor colorWithRed:0.794 green:0.945 blue:1.000 alpha:1.000]];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view02.mas_bottom).offset(10);
        make.right.left.equalTo(@0);
    }];
    
    UILabel *lab2=[[UILabel alloc] init];
    lab2.text=@"评价";
    [view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
    }];
    
    YFevaluator *eva=[[YFevaluator alloc] init];
    eva.count=5,eva.unit=.5;
    [view addSubview:eva];
    self.eva=eva;
    [eva setBackgroundColor:[UIColor clearColor]];
    [eva mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab2.mas_bottom).offset(10);
        make.left.equalTo(@20);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    YFTv *tv=[[YFTv alloc] init];
    [view addSubview:tv];
    [tv setPh:@"评价信息"];

    tv.layer.borderWidth=1;
    tv.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    tv.layer.cornerRadius=3;
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(eva.mas_bottom).offset(30);
        make.bottom.equalTo(@-10);
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.height.equalTo(@120);
    }];
    self.tv=tv;
    
    
    
    UIButton *btn=[[UIButton alloc] init];
    [self.contentv addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(25);
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.bottom.equalTo(@-20);
        make.height.equalTo(@44);
    }];
    [btn setBackgroundColor:[UIColor colorWithRed:0.494 green:0.660 blue:1.000 alpha:1.000]];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside] ;
    self.btn=btn;
    
    
    
    
}

-(void)onBtnClicked:(id)sender{
    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
       UIView *view= [sender view];
        if(view==self.sel1){
            self.sel1.selected=YES;
             self.sel2.selected=NO;
        }else if(view==self.sel2){
            self.sel2.selected=YES;
            self.sel1.selected=NO;
        }
    }else if(self.btn==sender){
        [self.tv resignFirstResponder];
        [UIViewController popVC];
    }else if(self.item==sender) {
        if(_sel1.selected){
            self.iv01.image=img(@"111");
            [self.view01 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@200);
            }];
        }else{
             self.iv02.image=img(@"222");
            [self.view02 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@200);
            }];
        }
    }
    
}



@end
