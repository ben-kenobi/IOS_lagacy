//
//  YFNavVC.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNavVC.h"

@implementation YFNavVC


-(void)viewDidLoad{
    [super viewDidLoad];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [viewController.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:@10} forState:UIControlStateNormal];
    if(self.childViewControllers.count>0)
        viewController.hidesBottomBarWhenPushed=YES;
    [super pushViewController:viewController animated:animated];
}

@end
