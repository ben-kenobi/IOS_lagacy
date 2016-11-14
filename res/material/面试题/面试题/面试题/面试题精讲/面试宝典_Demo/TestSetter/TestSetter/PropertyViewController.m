//
//  PropertyViewController.m
//  TestSetter
//
//  Created by qianfeng on 14-6-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()

@end

@implementation PropertyViewController

@synthesize Number1, Number2;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self setNumber1: 1];
    [self setNumber2: 2];
    
    NSLog(@"Number1:%d\nNumber1 + 2:%d", [self Number1], Number1 + 2);
    NSLog(@"Number2:%d\nNumber2 + 2:%d", [self Number2], Number2 + 2);
    [super viewDidLoad];
}

@end
