//
//  ViewController.m
//  正则表达式-01
//
//  Created by itheima on 15/12/23.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"aaa<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>bbb";
    
    // 正则表达式
    // Pattern - 匹配的方案，主要用于过滤字符串使用的
    /**
        程序员一般只需要知道几个符号即可
        .   匹配任意字符，除了换行
        *   匹配任意多个字符
        ?   尽量少匹配
     
        () 会让 range 的数量增加
        索引 0，是与整个 pattern 匹配的内容
        索引 1，从左至右依次递增 ()
     
        不带圆括号会匹配，但是不会在匹配索引中增加！
     
        pattern 的编写技巧，
        1. 可以复制原有的字符串
        2. 找到`特征的字符串(<a href=)(</a>)`作为识别标记，保持不动
        3. 需要拿到的内容，使用 (.*?)
        4. 需要忽略的内容，使用 .*?
     
        复杂的正则表达式，可以去网络搜索！
    */
    NSString *pattern = @"<a href=\"(.*?)\".*?>(.*?)</a>";
    
    // 绝大多数，以下代码不会有太大的变化
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
    
    // 开始匹配
    // firstMatchInString 匹配第一项
    // matchesInString 匹配多个项
    NSTextCheckingResult *result = [regx firstMatchInString:str options:0 range:NSMakeRange(0, str.length)];
    
    // 匹配结果
    // rangeAtIndex - 返回指定索引位置的range
    // numberOfRanges - 所有匹配项
    NSRange r1 = [result rangeAtIndex:0];
    NSString *sub1 = [str substringWithRange:r1];
    
    NSRange r2 = [result rangeAtIndex:1];
    NSString *sub2 = [str substringWithRange:r2];
    
    NSRange r3 = [result rangeAtIndex:2];
    NSString *sub3 = [str substringWithRange:r3];


    
    NSLog(@"%tu -- %@ --- %@ -- %@", result.numberOfRanges, sub1, sub2, sub3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
