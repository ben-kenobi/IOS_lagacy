//
//  MyCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "MyCon.h"
#import "Masonry.h"
#import "SettingCon.h"

@interface MyCon ()

@property (nonatomic,weak)UIButton *login;
@property (nonatomic,weak)UIButton *reg;
@property (nonatomic,weak)UIBarButtonItem *setting;

@property (nonatomic,weak)UIButton *btn;

@end

@implementation MyCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    self.navigationItem.title=@"my lottery";
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *ritem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onBtnClicked:)];
    self.navigationItem.rightBarButtonItem=ritem;
    self.setting=ritem;
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"NavInfoFlat"] forState:UIControlStateNormal];
    [btn setTitle:@"mlo" forState:UIControlStateNormal];
    [btn sizeToFit];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
    UILabel *lab=[[UILabel alloc] init];

    lab.text=@"lwajefwjefoiwjefiew";
    lab.font=[UIFont boldSystemFontOfSize:22];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).offset(-20);

    }];
    
    UIImageView *iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LoginScreen"]];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(lab.mas_top).offset(-10);
    }];
    
    UIButton *login=[[UIButton alloc] init];
    UIButton *reg=[[UIButton alloc] init];
    UIImage *img=[self resizeImg:[UIImage imageNamed:@"RedButton"]];
    UIImage *imgpre=[self resizeImg:[UIImage imageNamed:@"RedButtonPressed"]];
    [login setTitle:@"login" forState:UIControlStateNormal];
    [login setBackgroundImage:img forState:UIControlStateNormal];
    [login setBackgroundImage:imgpre forState:UIControlStateHighlighted];
    [reg setTitle:@"reg" forState:UIControlStateNormal];
    [reg setBackgroundImage:img forState:UIControlStateNormal];
    [reg setBackgroundImage:imgpre forState:UIControlStateHighlighted];
    [self.view addSubview:login];
    [self.view addSubview:reg];
    self.login=login;
    self.reg=reg;
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@20);
        make.width.equalTo(self.view.mas_width).multipliedBy(.8);
        make.height.equalTo(@40);
    }];
    
    [reg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(login);
        make.top.equalTo(login.mas_bottom).offset(20);
        make.width.equalTo(self.view.mas_width).multipliedBy(.8);
        make.height.equalTo(@40);
    }];
    
    
}


-(void)onBtnClicked:(id)sender{
    if(sender==self.setting){
       SettingCon *con= [[NSClassFromString(@"SettingCon") alloc] init];
        [con setPlistname:@"setting"];
        [self.navigationController showViewController:con sender:nil];
    }
}
-(UIImage *)resizeImg:(UIImage *)img{
    
    CGSize size=img.size;
    CGFloat x=size.width*.5,y=size.height*.5;
    return  [img resizableImageWithCapInsets:(UIEdgeInsets){y,x,y,x} resizingMode:UIImageResizingModeStretch];
}

@end
