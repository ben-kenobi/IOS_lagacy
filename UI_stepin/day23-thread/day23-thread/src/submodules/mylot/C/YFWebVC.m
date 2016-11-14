//
//  YFWebVC.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFWebVC.h"

@interface YFWebVC ()<UIWebViewDelegate>

@property (nonatomic,weak)UIWebView *web;
@property (nonatomic,weak)UIBarButtonItem *back;

@end

@implementation YFWebVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)loadView{
    self.view=[[UIWebView alloc] init];
    self.web=(UIWebView *)self.view;
    self.web.delegate=self;
    [self updateUI];
}

-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}
-(void)updateUI{
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:iRes( self.dict[@"html"])]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.location.href='#%@';",self.dict[@"id"]]];
}


-(void)onItemClicked:(id)sender{
    if(sender==self.back){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)initUI{
    self.title=self.dict[@"title"];
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
    self.navigationItem.leftBarButtonItem=back;
    self.back=back;
}

@end
