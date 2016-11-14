//
//  ViewController.m
//  day10-ui-autoresizing
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"


@interface ViewController ()


@property (nonatomic,weak)UIView *redv;
@property (nonatomic,weak)UIView *bluev;
@property (nonatomic,weak)UIButton *btn1;
@property (nonatomic,weak)UIButton *btn2;
@property (nonatomic,weak)UIButton *btn3;
@property (nonatomic,weak)UIButton *ranke;
@property (nonatomic,weak)UIButton *play;
@property (nonatomic,weak)UIButton *get;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI3];
}

-(void)initUI3{
    UIButton *(^createBtn)(UIView *)=^(UIView *supV){
        UIButton *btn=[[UIButton alloc]init];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:.8]];
        [supV addSubview:btn];
        return btn;
    };
    
    self.btn1=createBtn(self.view);
    self.btn2=createBtn(self.view);
    self.btn3=createBtn(self.view);
    
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).multipliedBy(.02);
        make.centerY.equalTo(self.view.mas_centerY).multipliedBy(168.0/240.0);
        make.width.equalTo(self.view.mas_width).multipliedBy(.14);
        make.height.equalTo(self.view.mas_height).multipliedBy(.08);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(self.btn1);
        make.top.equalTo(self.btn1.mas_bottom).multipliedBy(1.08);
    }];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(self.btn2);
        make.top.equalTo(self.btn2.mas_bottom).multipliedBy(1.05);
    }];
    
    
    self.ranke=createBtn(self.view);
    self.play=createBtn(self.view);
    self.get=createBtn(self.view);
    
    [self.ranke mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).multipliedBy(.03);
        make.bottom.equalTo(self.view.mas_bottom).multipliedBy(.86);
        make.height.equalTo(self.view).multipliedBy(.1);
        make.width.equalTo(self.view).multipliedBy(.27);
    }];
    
    
    [self.play mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ranke.mas_right).multipliedBy(1.02);
        make.bottom.equalTo(self.view.mas_bottom).multipliedBy(.89);
        make.height.equalTo(self.view).multipliedBy(.15);
        make.width.equalTo(self.view).multipliedBy(.4);
    }];
    [self.get mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.play.mas_right).multipliedBy(1.01);
        make.bottom.width.height.equalTo(self.ranke);
        
    }];
    
    
}

-(void)initUI2{
    UIView *blue=[[UIView alloc] initWithFrame:(CGRect){0,0,150,150}];
    [self.view addSubview:blue];
    self.bluev=blue;
    [blue setBackgroundColor:[UIColor blueColor]];
    
    UIView *red=[[UIView alloc] initWithFrame:(CGRect){0,100,150,50}];
    [self.bluev addSubview:red];
    self.redv=red;
    [red setBackgroundColor:[UIColor redColor]];
    
    
    [blue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.centerY.equalTo(self.view.mas_centerY).offset(-30);
        make.height.mas_equalTo(40);
    }];
    [red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(blue.mas_right);
        make.top.equalTo(blue.mas_bottom).offset(30);
        make.height.equalTo(blue.mas_height);
        make.width.equalTo(blue.mas_width).multipliedBy(.5)    ;
    
    }];
}


-(void)initUI{
    UIView *blue=[[UIView alloc] initWithFrame:(CGRect){0,0,150,150}];
    [self.view addSubview:blue];
    self.bluev=blue;
    [blue setBackgroundColor:[UIColor blueColor]];
    
    UIView *red=[[UIView alloc] initWithFrame:(CGRect){0,100,150,50}];
    [self.bluev addSubview:red];
    self.redv=red;
    [red setBackgroundColor:[UIColor redColor]];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [blue setTranslatesAutoresizingMaskIntoConstraints:NO];
    [red setTranslatesAutoresizingMaskIntoConstraints:NO];
    
//    [red setAutoresizingMask:UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight];
    
    NSLayoutConstraint *bluconLc=[NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30];
    NSLayoutConstraint *bluconRc=[NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30];
     NSLayoutConstraint *bluconCy=[NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-20];
     NSLayoutConstraint *bluconH=[NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:40];
    [self.view addConstraints:@[bluconLc,bluconRc,bluconCy]];
    [blue addConstraints:@[bluconH]];
    
    
    NSLayoutConstraint *redconRc=[NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *redconTc=[NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    NSLayoutConstraint *redconH=[NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *redconW=[NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeWidth multiplier:.5 constant:0];
    
    [self.view addConstraints:@[redconRc,redconTc,redconH,redconW]];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGRect frame=self.bluev.frame;
    frame.size.width+=20;
    frame.size.height+=20;
    self.bluev.frame=frame;
  }


@end
