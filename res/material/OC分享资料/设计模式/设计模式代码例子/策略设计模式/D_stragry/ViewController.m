//
//  ViewController.m
//  D_stragry
//
//  Created by qrh on 14-3-11.
//  Copyright (c) 2014年 qrh. All rights reserved.
//

#import "ViewController.h"
#import "Zhaoyun.h"
#import "Backdoor.h"
#import "Green.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Zhaoyun *zhao = [Zhaoyun new];
    [zhao didRun:[Backdoor new]];
    [zhao didRun:[Green new]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
