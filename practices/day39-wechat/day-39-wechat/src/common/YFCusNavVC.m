//
//  YFBasNavVC.m
//  day39-project01
//
//  Created by apple on 15/11/21.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFCusNavVC.h"
#import "YFTabBarVC.h"
@interface YFCusNavVC ()


@end

@implementation YFCusNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    YFTabBarVC *tab=self.tabBarController;
    if( self.navigationController.childViewControllers.count==1){
        tab.bottom.hidden=NO;
    }else{
        tab.bottom.hidden=YES;
        tab.subbot.hidden=YES;
    }
        
    
}


-(void)initNav{
    self.navigationController.navigationBar.hidden=YES;
    UIView *nav=[[UIView alloc] initWithFrame:(CGRect){0,0,iScreenW,iTopBarH}];
    [nav setBackgroundColor:iGolbalGreen];
    [self.view addSubview:nav];
    UIButton *lb=[[UIButton alloc] initWithFrame:(CGRect){0,iStBH,iNavH,iNavH}];
    [nav addSubview:lb];
    [lb addTarget:self action:@selector(onLbClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.lb=lb;
    [lb setImage:img(@"nav_back") forState:UIControlStateNormal];
    UIButton *rb=[[UIButton alloc] init];
    [nav addSubview:rb];
    [rb addTarget:self action:@selector(onRbClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rb=rb;
    rb.titleLabel.font=iFont(15);
    [rb setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    UILabel *title=[[UILabel alloc] initWithFrame:(CGRect){iNavH,iStBH,iScreenW-2*iNavH,iNavH}];
    [nav addSubview:title];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFont:iBFont(20)];
    self.navtitle=title;
    title.text=self.navtitleStr;
    BOOL login=YES;
    [self updateLoginState:login];
    
    

}

-(void)updateLoginState:(BOOL)login{
    if(login){
        [self.rb setTitle:@"" forState:UIControlStateNormal];
        [self.rb setImage:img(@"nav_user") forState:UIControlStateNormal];
        self.rb.frame=(CGRect){iScreenW-iNavH,iStBH,iNavH,iNavH};
    }else{
        [self.rb setImage:0 forState:UIControlStateNormal];
        [self.rb setTitle:@"登录/注册" forState:UIControlStateNormal];
        [self.rb sizeToFit];
        self.rb.frame=(CGRect){iScreenW-self.rb.w-16,iStBH,self.rb.w+16,iNavH};
    }
}


-(void)onLbClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onRbClicked:(UIButton *)sender{
   
}

@end
