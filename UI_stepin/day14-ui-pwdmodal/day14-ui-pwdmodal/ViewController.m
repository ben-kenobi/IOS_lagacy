//
//  ViewController.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "YFNumPad.h"
#import "YFPwdPad.h"

@interface ViewController ()<YFNumPadDelegate,YFPwdPadDelegate>

@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)YFNumPad *pad;
@property (nonatomic,assign)BOOL showPad;
@property (nonatomic,weak)YFPwdPad *pwdpad;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}

-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.btn){
        self.showPad=YES;
    }
}

-(void)onPadBtnClicked:(UIButton *)sender{
    NSInteger tag=sender.tag;
    if(tag==11){
        self.showPad=NO;
    }else if(tag==9){
        [self.pwdpad deleteLast];
    }else if(tag<9){
        [self.pwdpad append:[NSString stringWithFormat:@"%ld",tag+1]];
    }
}

-(void)onPwdChange:(NSString *)pwd full:(BOOL)full{
    
}

-(void)onCommit:(NSString *)pwd{
    NSLog(@"%@",pwd);
    self.showPad=NO;
}

-(void)setShowPad:(BOOL)showPad{
    _showPad=showPad;
    
    [self.pad mas_updateConstraints:^(MASConstraintMaker *make) {
        if(_showPad){
            make.top.equalTo(self.view.mas_bottom).offset(-self.pad.frame.size.height);
        } else{
            make.top.equalTo(self.view.mas_bottom);
        }
    }];
    
    
    [UIView animateWithDuration:.3 animations:^{
        [self.pad layoutIfNeeded];
    }];
    
    [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pwdpad.alpha=_showPad?1:0;
        self.pwdpad.transform=CGAffineTransformMakeScale(_showPad?1:.3, _showPad?1:.3);
    } completion:^(BOOL b){
        if(!self.showPad)
            [self.pwdpad initState];
    }];
    
}

-(void)initListeners{
    [self.btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initState{
    
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn =[[UIButton alloc] init];
    [btn setTitle:@"enterPwd" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    self.btn=btn;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    
    YFNumPad *pad=[YFNumPad padWithDelegate:self];
    [self.view addSubview:pad];
    self.pad=pad;
    
    [pad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(.3);
        make.top.equalTo(self.view.mas_bottom);
    }];
    
    
    YFPwdPad *pp=[YFPwdPad pwdPadWithLen:6 delegate:self];
    [self.view addSubview:pp];
    self.pwdpad=pp;
    [pp setBackgroundColor:[UIColor orangeColor]];
    [pp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(.3);
        make.width.equalTo(self.view).multipliedBy(.8);
    }];
    
    pp.alpha=0;
    pp.transform=CGAffineTransformMakeScale(.3, .3);
    
    
}

@end
