//
//  ViewController2.m
//  day12-ui-appApplication
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController.h"


@interface ViewController2 ()

@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UIButton *btn2;

@end

@implementation ViewController2


-(void)viewWillUnload{
    [super viewWillUnload];
    NSLog(@"will unload--%d",2);
}
-(void)viewDidUnload{
    [super viewDidUnload];
    NSLog(@"unload--%d",2);
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"appear--%d",2);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"will appear--%d",2);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"will disappear---%d",2);
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"disappear---%d",2);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    NSLog(@"view didload---%d",2);
}
-(void)initUI{
    [self.view setBackgroundColor:[UIColor blueColor]];
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){10,10,100,240}];
    [btn setTitle:@"next" forState:UIControlStateNormal] ;
    [self.view addSubview:btn];
    self.btn=btn;
    
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[[UIButton alloc] initWithFrame:(CGRect){10,210,100,240}];
    [btn2 setTitle:@"prev" forState:UIControlStateNormal] ;
    [self.view addSubview:btn2];
    self.btn2=btn2;
    
    [btn2 addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];}

-(void)onBtnClicked:(UIButton *)btn{
    if(btn==self.btn){
        UIViewController *c1,*c2,*c3;
        c1=[[ViewController alloc] init];
        c2=[[ViewController2 alloc]init];
        c3=[[ViewController3 alloc] init];
        [self.navigationController pushViewController:c3 animated:YES];
    }else if(btn==self.btn2){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
