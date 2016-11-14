//
//  YFHisVC.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHisVC.h"

@interface  YFHisVC ()
@property (nonatomic,weak)UIButton *btn;

@end

@implementation YFHisVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor orangeColor]];
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){0,0,120,44}];
    [btn setTitleEdgeInsets:(UIEdgeInsets){0,10,0,0}];
    [btn setImage:[UIImage imageNamed:@"pushSettings"] forState:UIControlStateNormal];
    [btn setTitle:@"lotteryinfo" forState:UIControlStateNormal];

    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=item;
    self.btn=btn;
    
}

@end
