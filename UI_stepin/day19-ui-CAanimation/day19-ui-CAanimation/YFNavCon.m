//

//  YFNavCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNavCon.h"

@interface YFNavCon ()

@end

@implementation YFNavCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];

}


-(void)showViewController:(UIViewController *)vc sender:(id)sender{
    vc.hidesBottomBarWhenPushed=YES;
    [super showViewController:vc sender:sender];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
