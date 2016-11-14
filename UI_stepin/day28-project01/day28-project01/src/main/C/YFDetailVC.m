//
//  YFDetailVC.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDetailVC.h"
#import "MBProgressHUD+ZJ.h"
#import "YFTable.h"

@interface YFDetailVC ()
@property (nonatomic,weak)UIWebView *wv;
@property (nonatomic,weak)YFTable *tv;

@end

@implementation YFDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    [self initUI2];
}

-(void)initUI2{
    YFTable *tv=[[YFTable alloc] init];
    [self.view addSubview:tv];
    self.tv=tv;
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(@-100);
    }];
    [tv.layer setBorderColor:[[UIColor rgba:@[@.7,@.7,@.7,@1]] CGColor]];
    [tv.layer setBorderWidth:1];
    [tv setSeparatorStyle:0];
    
//    [tv setRowHeight:UITableViewAutomaticDimension];
//    [tv setEstimatedRowHeight:44];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [NSThread sleepForTimeInterval:1];
//         [tv setDatas:@[@{@"key":@"qweq13123123123qweqwewqewqeqwewqewq123123123123123123123we",@"val":@"qweqwe"},@{@"key":@"13123123213",@"val":@"e21e21e2e"},@{@"key":@" dqdwq",@"val":@"e123123123123213123qweqwqweqweqweqweqwewqewqewqeqweqweqweqweqweqwe12312312312312312k3j1k23k123h2e2e2"}]];
//    });
    [self loadData];
   
   
}

-(void)loadData{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(self.dict[@"url"]) cachePolicy:1 timeoutInterval:5];
    [MBProgressHUD showMessage:@"loading..."];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(data&&!error){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.tv.confirm=self.confirm;
                self.tv.dict=dict;
            });
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        
    }] resume];
}

-(void)initUI{
    UIWebView *wv=[[UIWebView alloc] init];
    [self.view addSubview:wv];
    self.wv=wv;
    [wv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.equalTo(@-100);
    }];
    [self loadUrl];
    
}

-(void)loadUrl{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(self.dict[@"image"]) cachePolicy:1 timeoutInterval:5];
    [MBProgressHUD showMessage:@"loading..."];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self.wv loadData:data MIMEType:response.MIMEType   textEncodingName:response.textEncodingName baseURL:iURL(self.dict[@"url"])];
            });
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        
    }] resume];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIViewController popVC];
}


@end
