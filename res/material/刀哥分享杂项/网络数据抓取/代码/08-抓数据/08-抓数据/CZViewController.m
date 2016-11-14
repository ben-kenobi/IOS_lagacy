//
//  CZViewController.m
//  08-抓数据
//
//  Created by apple on 02/08/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZViewController.h"
#import "NSString+Regex.h"

#define kBaseURL        @"http://zhougongjiemeng.1518.com/"

@interface CZViewController ()

@end

@implementation CZViewController
/**
 抓数据是偷东西，要准确，顺序，所有方法都用同步的
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self spider];
}

#pragma mark - 网路爬虫
- (void)spider
{
    // 1. url
    NSURL *url = [NSURL URLWithString:kBaseURL];
    
    // 2. urlrequet
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. connection
    // 抓数据时，一定要做错误提示，否则会浪费很多时间
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    
    // 4. 转换成字符串
    NSString *html = [NSString UTF8StringWithHZGB2312Data:data];
    
//    NSLog(@"%@", html);
//    
    // 5. 提示：做字符串分析，范围越集中越好
    // 5.1 找到列表部分的文字，*** 一定要确定一个唯一的标记
    // 正则表达式
    
    // 在整个html字符串中，查询<ul class=\"cs_list\">开头，到</ul>之间所有的内容
    // 要获取到的内容，使用(.*?)
    NSString *pattern = [NSString stringWithFormat:@"<ul class=\"cs_list\">(.*?)</ul>"];
//    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:NULL];
//    
//    // 匹配一个内容
//    NSTextCheckingResult *result = [regx firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];
//    NSRange r = [result rangeAtIndex:1];
//    NSString *content = [html substringWithRange:r];
    
    NSString *content = [html firstMatchWithPattern:pattern];
    
//    NSLog(@"%@", content);
    
    // 从content中生成数组
    // 写pattern的步骤
    // 1> 确定唯一性
    // 2> 从html中粘出唯一性的字符串
    // 3> 把字符串增加转义
    // 4> 使用(.*?)替代要查找的内容
    NSString *p = @"<li><a href=\"(.*?)\">(.*?)</a>\\((.*?)\\)</li>";
    // 1> 匹配方案
    // 2> 每一个字符串顺序对应(.*?)的字典键名
    NSArray *array = [content matchesWithPattern:p keys:@[@"url", @"title", @"count"]];
    
    for (NSDictionary *dict in array) {
        [self spider2WithDict:dict];
     
        // 第一个就断掉
        break;
    }
    
    NSLog(@"%@", array);
}

- (void)spider2WithDict:(NSDictionary *)dict
{
    
}

@end
