//
//  YFArenaVC.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFArenaVC.h"

@interface YFArenaVC ()
@property (nonatomic,weak)UISegmentedControl *seg;

@end

@implementation YFArenaVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"1212312"] CGImage];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    UISegmentedControl *seg=[[UISegmentedControl alloc] initWithItems:@[@"football",@"basketball"]];
    [seg setTintColor:[UIColor clearColor]];
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView=seg;
    [seg setSelectedSegmentIndex:0];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [seg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}


@end
