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
@property (nonatomic, strong) NSMutableArray *dataListM;
@end

@implementation CZViewController

- (NSMutableArray *)dataListM
{
    if (_dataListM == nil) _dataListM = [NSMutableArray array];
    return _dataListM;
}

/**
 抓数据是偷东西，要准确，顺序，所有方法都用同步的
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self spider];
}

- (NSString *)htmlWithURLString:(NSString *)urlString
{
    // 1. url
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. urlrequet
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. connection
    // 抓数据时，一定要做错误提示，否则会浪费很多时间
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    
    // 4. 转换成字符串
    return [NSString UTF8StringWithHZGB2312Data:data];
}

#pragma mark - 网路爬虫
- (void)spider
{
    NSString *html = [self htmlWithURLString:kBaseURL];

    NSString *pattern = [NSString stringWithFormat:@"<ul class=\"cs_list\">(.*?)</ul>"];
    NSString *content = [html firstMatchWithPattern:pattern];
    
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
    }
    
    NSLog(@"大功告成！！！");
    // 写入文件
    [self.dataListM writeToFile:@"/Users/apple/Desktop/123.plist" atomically:YES];
}

- (void)spider2WithDict:(NSDictionary *)dict
{
    // 1. html
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseURL, dict[@"url"]];
    NSString *html = [self htmlWithURLString:urlString];
    
//    NSLog(@"%@", html);
    
    // 2. content
    // (.*?) => 要抓的内容
    // .*? => 要忽略的内容
    NSString *content = [html firstMatchWithPattern:@"<div class=\"listpage_content\">.*?<ul>(.*?)</ul>"];
//    NSLog(@"%@", content);
    
    // 3. 数组
    NSArray *array = [content matchesWithPattern:@"<li><a href=\"(.*?)\">(.*?)</a></li>" keys:@[@"url", @"name"]];
//    NSLog(@"%@", array);
    
    for (NSDictionary *d in array) {
        [self spider3WithDict:d withCategory:dict[@"title"]];
        
        NSLog(@"正在抓取 %@ ...", d[@"name"]);
        
        [NSThread sleepForTimeInterval:0.1];
    }
}

- (void)spider3WithDict:(NSDictionary *)dict withCategory:(NSString *)category
{
    // 1. html
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseURL, dict[@"url"]];
    NSString *html = [self htmlWithURLString:urlString];
    
//    NSLog(@"%@", html);
    
    // 2. 抓词条描述
    NSString *desc = [html firstMatchWithPattern:@"<dd>(.*?)</dd>"];
    // *** 处理 <br />
    desc = [desc stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
//    NSLog(@"%@", desc);
    
    // 3. 抓相关词条
    NSString *content = [html firstMatchWithPattern:@"相关词条:(.*?)</div>"];
//    NSLog(@"%@", content);
    
    // 4. 生成数组
    NSArray *array = [content matchesWithPattern:@"<a href=\".*?\"><u>(.*?)</u></a>" keys:@[@"title"]];
//    NSLog(@"%@", array);
    
    NSDictionary *item = @{@"category": category, @"title": dict[@"name"], @"desc": desc};

    [self.dataListM addObject:item];
}

@end
