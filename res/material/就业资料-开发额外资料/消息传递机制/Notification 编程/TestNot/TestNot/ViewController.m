//
//  ViewController.m
//  TestNot
//
//  Created by 赵繁 on 15/12/16.
//  Copyright © 2015年 赵繁. All rights reserved.
//

/**
 测试：
 1.没有remove通知的监听者，如果对象释放，再发通知。会不会崩溃？ 没有崩溃。
 2.没有崩溃原因猜测： 1>系统自动在对象释放时，进行了remove 2>新版本的Xcode做出了优化，通知中心 __weak 引用监听者，所以对象释放后，指针被置为nil。再向其发消息，不会崩溃.
 3.结论：系统没有自动调用remove。所以是新版本的Xcode对其进行了优化。
 4.Xcode6.4会崩溃。
 
 */


#import "ViewController.h"
#import "Person.h"
#import "NSNotificationCenter+TEST.h"

@interface ViewController ()
//@property (nonatomic, strong) Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *p = [[Person alloc] init];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:p];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点了");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TEST_NOTIFICATION" object:nil];
}


@end

