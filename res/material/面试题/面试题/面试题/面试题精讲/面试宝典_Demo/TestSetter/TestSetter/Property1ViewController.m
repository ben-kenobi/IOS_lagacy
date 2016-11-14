//
//  Property1ViewController.m
//  TestSetter
//
//  Created by qianfeng on 14-6-25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "Property1ViewController.h"

@interface Property1ViewController ()

@end

@implementation Property1ViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self setNumber1: 1];
    [self setNumber2: 2];
    
    NSLog(@"Number1:%d  Number1 + 2:%d", [self Number1], Number1 + 2);
    NSLog(@"Number2:%d  Number2 + 2:%d", [self Number2], Number2 + 2);
    [super viewDidLoad];
}

//对象的setter方法
- (void) setNumber1:(NSInteger) Num{
    Number1 = Num;
}

- (void) setNumber2:(NSInteger) Num{
    Number2 = Num;
}

//对象的getter方法
- (NSInteger) Number1{
    return Number1;
}

- (NSInteger) Number2{
    return Number2;
}

-(void)setNumber3:(NSNumber *)number
{
    if(![Number3 isEqual:number])
    {
        Number3 = number;
    }
}


-(NSNumber *)Number3
{
    return Number3;
}

@end
