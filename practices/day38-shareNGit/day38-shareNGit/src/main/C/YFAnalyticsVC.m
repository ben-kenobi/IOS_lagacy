
//
//  YFAnalyticsVC.m
//  day38-shareNGit
//
//  Created by apple on 15/11/29.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFAnalyticsVC.h"
#import "MobClick.h"
@interface YFAnalyticsVC ()

@end

@implementation YFAnalyticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor randomColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",NSStringFromClass(self.class)]];
    
    [MobClick event:@"page content description"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",NSStringFromClass(self.class)]];
}

@end
