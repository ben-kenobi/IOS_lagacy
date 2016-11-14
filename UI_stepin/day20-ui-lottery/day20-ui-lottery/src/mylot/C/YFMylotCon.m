//
//  YFMylotCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMylotCon.h"
#import "YFSettingCon.h"
#import "YFCate.h"
#import "Masonry.h"

@interface YFMylotCon ()
@property (nonatomic,weak)UIBarButtonItem *setting;
@property (nonatomic,weak)UIButton *lbtn;
@property (nonatomic,weak)UIButton *login;
@property (nonatomic,weak)UIButton *reg;


@end


@implementation YFMylotCon


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *setting=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Mylottery_config"] style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClicked:)];
    self.setting=setting;
    self.navigationItem.rightBarButtonItem=setting;
    
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:(UIEdgeInsets){0,10,0,0}];
    [btn sizeToFit];
    btn.w+=10;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    

    UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginScreen"]];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
    }];
    UILabel *lab=[[UILabel alloc] init];
    lab.text=@"qeqweqweqweqweqweqwewqeqwewqe";
    [lab setFont:[UIFont boldSystemFontOfSize:22]];
    [lab setTextColor:[UIColor grayColor]];
    [lab setNumberOfLines:0];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lab];
    [lab sizeToFit];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_right).multipliedBy(.2);
        make.right.equalTo(self.view.mas_right).multipliedBy(.8);
    }];
    
    UIImage *img=[[UIImage imageNamed:@"RedButton"] resizableStretchImg];
    UIImage *pres=[[UIImage imageNamed:@"RedButtonPressed"] resizableStretchImg];
    UIButton *login=[[UIButton alloc] init];
    [login setBackgroundImage:img forState:UIControlStateNormal];
    [login setBackgroundImage:pres forState:UIControlStateHighlighted];
    [login setTitle:@"login" forState:0];
    [self.view addSubview:login];
    self.login=login;
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(.8);
        make.height.equalTo(@44);
        make.top.equalTo(lab.mas_bottom).offset(20);
        make.centerX.equalTo(@0);
    }];
    
    
    UIButton *reg=[[UIButton alloc] init];
    [reg setBackgroundImage:img forState:UIControlStateNormal];
    [reg setBackgroundImage:pres forState:UIControlStateHighlighted];
    [reg setTitle:@"reg" forState:UIControlStateNormal];
    [self.view addSubview:reg];
    self.reg=reg;
    [reg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.login);
        make.top.equalTo(self.login.mas_bottom).offset(20);
    }];

    
}



-(void)onBtnClicked:(id)sender{
    if(sender==self.setting){
        YFSettingCon *con=[[YFSettingCon alloc] init];
        [con setPname:@"setting"];
        con.title=@"settings";
        [self.navigationController showViewController:con sender:0];
    }
}

@end
