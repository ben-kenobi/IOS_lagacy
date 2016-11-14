//
//  VC02.m
//  day27-network
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "VC02.h"

@interface VC02 ()
@property (nonatomic,weak)UIWebView *wv;

@end

@implementation VC02

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIWebView *wv=[[UIWebView alloc] initWithFrame:(CGRect){0,20,self.view.w,self.view.h-100}];

    [self.view addSubview:wv];
    self.wv=wv;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(@"http://127.0.0.1/resources/vedios.json") cachePolicy:1 timeoutInterval:15];
    NSURLSession *ses=[NSURLSession sharedSession];

    NSURLSessionDataTask *dt=[ses dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
           NSString *str=[[NSString alloc] initWithData:data encoding:4];
            id json= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:0];
            NSLog(@"%@",[json class]);
            [self.wv loadHTMLString:str baseURL:iURL(@"http://127.0.0.1/")];
        }
    }];
    [dt resume];
}

@end
