//
//  HisCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HisCon.h"

@interface HisCon ()

@property (nonatomic,weak)UIBarButtonItem *item;

@end

@implementation HisCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
     self.navigationItem.title=@"history";
    self.view.backgroundColor=[UIColor orangeColor];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){0,0,100,30}];
    [btn setImage:[UIImage imageNamed:@"pushSettings"] forState:UIControlStateNormal];
    [btn setTitle:@"titletitle" forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:(UIEdgeInsets){0,10,0,0}];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=item;
    
    self.item=item;
}





@end
