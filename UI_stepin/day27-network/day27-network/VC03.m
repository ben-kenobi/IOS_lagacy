//
//  VC03.m
//  day27-network
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "VC03.h"
#import "YFVideoTV.h"
#import "YFVideoTV02.h"
@interface VC03 ()<NSXMLParserDelegate>
@property (nonatomic,weak)YFVideoTV *tv;
@property (nonatomic,weak)UIWebView *wv;
@property (nonatomic,weak)YFVideoTV02 *tv02;

@end

@implementation VC03

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI3];
    

}


-(void)initUI3{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YFVideoTV02 *tv02=[[YFVideoTV02 alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tv02=tv02;
    [self.view addSubview:tv02];
    [self.tv02 setRowHeight:80];
    self.tv02.con=self;
    [self asynDLDatas2];
}
-(void)initUI2{
    [self.view setBackgroundColor:[UIColor randomColor]];
    UIWebView *wv=[[UIWebView alloc] initWithFrame:(CGRect){0,20,self.view.w,self.view.h-100}];
    self.wv=wv;
    [self.view addSubview:wv];
}


-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YFVideoTV *tv=[[YFVideoTV alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tv=tv;
    [self.view addSubview:tv];
    [self.tv setRowHeight:80];
    self.tv.con=self;
    [self asynDLDatas];
}

-(void)asynDLDatas{
    
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(@"http://127.0.0.1/resources/vedios.json") cachePolicy:1 timeoutInterval:5];
   [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
        [self.tv setDatas:ary];
       
    }] resume];
    
}

-(void)asynDLDatas2{
    
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(@"http://127.0.0.1/resources/vedios.xml") cachePolicy:1 timeoutInterval:5];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        [self.tv02 setXMLData:data];
        
        
    }] resume];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(@"http://127.0.0.1/resources/vedios2.xml") cachePolicy:1 timeoutInterval:5];
     NSURLSessionDataTask *dt=[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSString *str=[[NSString alloc] initWithData:data encoding:4];
         
         NSXMLParser *parser=[[NSXMLParser alloc] initWithData:data];
         parser.delegate=self;
         [parser parse];
     }];

    [dt resume];
}





@end
