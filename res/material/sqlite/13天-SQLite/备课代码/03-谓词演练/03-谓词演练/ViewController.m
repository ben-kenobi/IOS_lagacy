//
//  ViewController.m
//  03-谓词演练
//
//  Created by 刘凡 on 15/12/20.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *arrayM = [NSMutableArray array];
    NSArray *names = @[@"zhàng", @"wang"];
    NSArray *titles = @[@"manager", @"boss"];
    
    for (NSInteger i = 0; i < 50; i++) {
        Person *p = [[Person alloc] init];
        
        p.name = [NSString stringWithFormat:@"%@ - %05zd", names[arc4random_uniform(2) ], i];
        p.title = titles[arc4random_uniform(2)];
        p.age = 18 + arc4random_uniform(20);
        
        [arrayM addObject:p];
    }
    
    NSLog(@"%@", arrayM);
    NSLog(@"-------------");
    NSInteger a = 30;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name LIKE %@ AND name CONTAINS '8') OR age > %d", @"zh*", a];
    NSArray *result = [arrayM filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", result);
}

- (void)demo {
    NSMutableArray *arrayM = [NSMutableArray array];
    NSArray *names = @[@"zhàng", @"wang"];
    
    for (NSInteger i = 0; i < 50; i++) {
        [arrayM addObject:[NSString stringWithFormat:@"%@ - %05zd", names[arc4random_uniform(2) ], i]];
    }
    NSLog(@"%@", arrayM);
    NSLog(@"-------------");
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] 'ang' AND self CONTAINS '8'"];
    NSArray *result = [arrayM filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", result);
}

@end
