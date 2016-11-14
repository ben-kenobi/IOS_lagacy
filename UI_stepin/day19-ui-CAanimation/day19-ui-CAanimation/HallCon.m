//
//  HallCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HallCon.h"
#import "UIColor+Extension.h"
@interface HallCon ()

@end

@implementation HallCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"HALL";
    [self initUI ];
    
    
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor randomColor]];
    

    UIImage *img=[UIImage imageNamed:@"CS50_activity_image"];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
    self.navigationItem.leftBarButtonItem=item;
}

-(void)onItemClicked:(id)sender{
    UIView *cover=[[UIView alloc] init];
    cover.frame=[UIScreen mainScreen].bounds;
    cover.tag=100;
    [cover setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
    [self.tabBarController.view addSubview:cover];
    
    UIImageView *iv=[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"showActivity"]];
    iv.center=self.tabBarController.view.center;
    [cover addSubview:iv];
    [iv setUserInteractionEnabled:YES];
    
    UIImage *img=[UIImage imageNamed:@"alphaClose"];
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){iv.bounds.size.width-img.size.width, 0,img.size}];
    [btn setImage:img forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [iv addSubview:btn];
}
-(void)onBtnClicked:(id)sender{
    [UIView animateWithDuration:.25 animations:^{
        [[self.tabBarController.view viewWithTag:100] setAlpha:0];
    } completion:^(BOOL finished) {
        [[self.tabBarController.view viewWithTag:100] removeFromSuperview];
    }];
    
    
}

@end
