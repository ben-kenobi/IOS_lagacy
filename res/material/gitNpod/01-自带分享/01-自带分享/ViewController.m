//
//  ViewController.m
//  01-自带分享
//
//  Created by itheima on 15/11/19.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

//导入框架的步骤, 在Xcode5以后, 大部分的可以不用导入. 报错的时候导入

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 点击分享
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 判断服务类型是否可用
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"应该先去设置中, 添加新浪微博账号, 然后再来分享");
        return;
    }
    
    //2. 创建分享控制器 --> 绑定服务类型
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    //2.1 文字
    [composeVC setInitialText:@"世界上有10种人, 一种是懂二进制的, 一种是不懂二进制的"];
    
    //2.2 图像
    [composeVC addImage:[UIImage imageNamed:@"mingxing1117"]];
    
    //2.3 网址
    [composeVC addURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    //3. 莫泰视图弹出显示
    [self presentViewController:composeVC animated:YES completion:nil];
}

@end
