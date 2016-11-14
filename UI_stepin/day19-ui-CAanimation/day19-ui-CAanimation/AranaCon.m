//
//  AranaCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AranaCon.h"

@interface AranaCon ()
@property (nonatomic,weak)UISegmentedControl  *segment;

@end

@implementation AranaCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"NLArenaBackground"] CGImage];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    UISegmentedControl *segment=[[UISegmentedControl alloc] initWithItems:@[@"football",@"basketball"]];
    self.navigationItem.titleView=segment;
    [segment setTintColor:[UIColor clearColor]];
    [segment setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [segment setSelectedSegmentIndex:0];
}



@end
