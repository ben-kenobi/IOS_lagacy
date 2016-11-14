//
//  YFBasicVC.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBasicVC.h"
#import "objc/runtime.h"



@implementation YFBasicVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:0 action:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    objc_setAssociatedObject(iApp, iVCKey, self, OBJC_ASSOCIATION_ASSIGN);
}

@end
