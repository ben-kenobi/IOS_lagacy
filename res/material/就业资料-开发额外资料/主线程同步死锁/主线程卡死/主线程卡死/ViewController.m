//
//  ViewController.m
//  主线程卡死
//
//  Created by 赵繁 on 15/12/20.
//  Copyright © 2015年 赵繁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(180, 200, 20, 20);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

// 主线程同步死锁
- (void)btnClick {
//    NSLog(@"%s", __func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"%s", __func__);
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"%s", __func__);
//    });
    
    [self demo2];
}

// 主线程同步死锁
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    [self demo1];
//}

// 主线程同步死锁
- (void)demo1 {
    dispatch_sync(dispatch_get_main_queue(), ^{
    });
}

// 不死锁
- (void)demo2 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"死锁么");
        });
        
        NSLog(@"哦，你猜错啦。。");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
