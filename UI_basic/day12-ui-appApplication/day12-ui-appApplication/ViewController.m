//
//  ViewController.m
//  day12-ui-appApplication
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import  "ViewController2.h"
#import  "ViewController3.h"

@interface ViewController ()

@property (nonatomic,weak)UIButton *btn;

@end

@implementation ViewController


-(void)viewWillUnload{
    [super viewWillUnload];
    NSLog(@"will unload--%d",1);
}
-(void)viewDidUnload{
    [super viewDidUnload];
    NSLog(@"unload--%d",1);
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"appear--%d",1);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"will appear--%d",1);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"will disappear---%d",1);
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"disappear---%d",1);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    NSLog(@"view didload---%d",1);
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor cyanColor]];
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){10,10,100,240}];
    [btn setTitle:@"next" forState:UIControlStateNormal] ;
    [self.view addSubview:btn];
    self.btn=btn;
    
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onBtnClicked:(UIButton *)btn{
    UIViewController *c1,*c2,*c3;
    c1=[[ViewController alloc] init];
    c2=[[ViewController2 alloc]init];
    c3=[[ViewController3 alloc] init];
    [self.navigationController pushViewController:c2 animated:YES];
}


@end
