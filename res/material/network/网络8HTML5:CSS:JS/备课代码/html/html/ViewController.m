//
//  ViewController.m
//  html
//
//  Created by 李凯宁 on 15/10/5.
//  Copyright © 2015年 李凯宁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *url =[[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
//    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSURL *url = [NSURL URLWithString:@"http://v3.bootcss.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    
    
//    NSString *js = @"var footer = document.getElementsByTagName('footer')[0];"
//    "footer.remove();";
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('footer')[0].remove();"];
}


@end
