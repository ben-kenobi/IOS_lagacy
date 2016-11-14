//
//  YFHallCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHallCon.h"
#import "YFCate.h"


@interface YFHallCon ()

@property (nonatomic,weak)UIBarButtonItem *item;


@end

@implementation YFHallCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    self.view.backgroundColor=[UIColor randomColor];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"CS50_activity_image"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClicked:)];
    self.navigationItem.leftBarButtonItem=item;
    self.item=item;
}


-(void)onBtnClicked:(id)sender{
    if(sender==self.item){
        UIView *sup=self.tabBarController.view;
        UIView *view=[[UIView alloc] initWithFrame:sup.frame];
        [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
        UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lucky_lots_tuhao"]];
        [iv setCenter:sup.center];
        [view addSubview:iv];
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"alphaClose"]  forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.frame=(CGRect){iv.bounds.size.width-btn.bounds.size.width,0,btn.bounds.size};
        [iv addSubview:btn];
        [self.tabBarController.view addSubview:view];
        [iv setUserInteractionEnabled:YES];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=1;
        
    }else if([sender tag]==1){
        UIView *v=[[sender superview] superview];
        [UIView animateWithDuration:.25 animations:^{
            v.alpha=0;
        } completion:^(BOOL finished) {
            [v removeFromSuperview];
        }];
    }
}


@end
