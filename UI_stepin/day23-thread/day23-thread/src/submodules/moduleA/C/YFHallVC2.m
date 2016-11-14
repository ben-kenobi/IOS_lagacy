//
//  YFHallVC2.m
//  day23-thread
//
//  Created by apple on 15/10/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHallVC2.h"
@interface YFHallVC2 ()

@property (nonatomic,weak)UIBarButtonItem *item;
@property (nonatomic,weak)UIView *cover;

@end

@implementation YFHallVC2


-(void)initUI{
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"WeiboSina"] style:0 target:self action:@selector(onItemClicked:)];
    self.navigationItem.leftBarButtonItem=item;
    self.item=item;
    
}

-(void)onItemClicked:(id)sender{
    NSInteger tag=[sender tag];
    if(sender==self.item){
        UIView *cover=[[UIView alloc] initWithFrame:iScreen.bounds];
        [cover setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
        [self.tabBarController.view addSubview:cover];
        self.cover=cover;
        UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lucky_lots_tuhao"]];
        iv.center=cover.center;
        [cover addSubview:iv];
        [iv setUserInteractionEnabled:YES];
        
        UIButton *btn=[[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"LuckyConfirmClose"] forState:UIControlStateNormal];
        [btn sizeToFit];
        [iv addSubview:btn];
        btn.y=0;btn.x=iv.w-btn.w;
        [btn addTarget:self action:@selector(onItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=2;
    }else if(tag==2){
        
        
        [UIView animateWithDuration:.3 animations:^{
            self.cover.alpha=0;
        } completion:^(BOOL finished) {
            [self.cover removeFromSuperview];
        }];
    }
    
   
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
  
}


@end
