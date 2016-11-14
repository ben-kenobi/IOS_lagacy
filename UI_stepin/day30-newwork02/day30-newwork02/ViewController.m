//
//  ViewController.m
//  day30-newwork02
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "YFImgSV.h"
#import "YFIndicator.h"
#import "Masonry.h"

#import "sqlite3.h"
#import "YFImgSV2.h"

#define key @"usernamekey"
@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic,weak)UIWebView *wv;
@property (nonatomic,weak)YFImgSV *sv;
@property (nonatomic,weak)YFIndicator *indicator;
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,weak)UIView *lab;

@property (nonatomic,weak)YFImgSV2 *sv2;
@end

@implementation ViewController
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"deal.sqlite"];
//    static sqlite3* _db;
//   int err= sqlite3_open([file fileSystemRepresentation],&_db );
//    printf("%d",err);
   
    
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initUI7];
}


-(void)initUI7{
    YFImgSV2 *sv2=[[YFImgSV2 alloc] initWithFrame:(CGRect){30,100,260,300}];
    [self.view addSubview:sv2];
    self.sv2=sv2;
    [sv2 setBackgroundColor:[UIColor whiteColor]];
    [sv2 setOnchange:^(CGFloat f) {

    }];
    [self loadDatas2];
}
-(void)loadDatas2{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://localhost/resources/ads.json"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            NSArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.sv2 appendDatas:ary];
            }) ;
            
        }else{
            NSLog(@"\nerror = %@",error);
        }
    }]resume];
}






//tv header   dragging
-(void)initUI6{
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tv=tv;
    [self.view addSubview:tv];
    UIView *header=[[UIView alloc] initWithFrame:(CGRect){0,0,0,0}];
    [self.tv setTableHeaderView:header];

    UILabel *lab=[[UILabel alloc] initWithFrame:header.frame];
    [header addSubview:lab];
    [lab setBackgroundColor:[UIColor orangeColor]];
    [lab setTextColor:[UIColor whiteColor]];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setFont:[UIFont boldSystemFontOfSize:40]];
    lab.layer.anchorPoint=(CGPoint){.5,1};
    [lab setText:@"DRAGGING"];
    self.lab=lab;
    
    [self.tv addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:0];
}
-(void)dealloc{
    [self.tv removeObserver:self forKeyPath:@"contentOffset"];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGPoint new=[change[@"new"] CGPointValue];
    CGPoint old=[change[@"old"] CGPointValue];
    self.lab.layer.opacity=0-new.y*.02;
  
    if(new.y<=-50){
        self.lab.layer.transform=CATransform3DMakeScale(1-(new.y+50)/30.0, 1-(new.y+50)/30.0, 1);
        CGRect frame= self.lab.frame;
        
        if(frame.origin.y>new.y){
            frame.size.height=-new.y;
            frame.origin.y=new.y;
        }
        self.lab.frame=frame;
        return ;
    }
    self.lab.layer.transform=CATransform3DIdentity;
    CGRect frame= self.lab.frame;
    frame.size.height=-new.y;
    frame.origin.y=new.y;
    self.lab.frame=frame;
  
    
}

//ad scroller
-(void)initUI5{
    YFImgSV *sv=[[YFImgSV alloc] initWithFrame:(CGRect){50,100,220,80}];
    [self.view addSubview:sv];
    self.sv=sv;
    [sv setOnchange:^(CGFloat f) {
        [self.indicator onchange:f];
    }];
    
    YFIndicator *indicator=[[YFIndicator alloc] init];
    indicator.center=(CGPoint){50+110,100+70};
    [self.view addSubview:indicator];
    self.indicator=indicator;
    self.indicator.tintColor=[UIColor cyanColor];
    
    [self loadDatas];
}
-(void)loadDatas{
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://localhost/resources/ads.json"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            NSArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.sv appendDatas:ary];
                self.indicator.count=ary.count;
            }) ;
           
        }else{
            NSLog(@"\nerror = %@",error);
        }
    }]resume];
}

//webView N js
-(void)initUI4{
    UIWebView *wv=[[UIWebView alloc] initWithFrame:(CGRect){0,0,self.view.bounds.size.width,self.view.bounds.size.height-100}];
    self.wv=wv;
    [self.view addSubview:wv];
    wv.delegate=self;
    
//    [wv loadData:[NSData dataWithContentsOfFile:@"/Users/apple/Sites/1.html"] MIMEType:0 textEncodingName:0 baseURL:0];
    
    [wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.youku.com"]]];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('contact').remove();"];
    NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('input')[0].remove();"]);
    
    
    NSString *str=[self.wv stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML"];
    
    NSLog(@"%@",str);
}


//cookie
-(void)initUI3{
    //first  login  ,get cookie
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://localhost/login/login2.php?username=111&password=111"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",response);
        NSLog(@"data=%@",[NSJSONSerialization JSONObjectWithData:data options:0 error:0]);
    }] resume];
    
    
    
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSLog(@"%@",storage.cookies);
    
    [storage.cookies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSHTTPCookie *cookie=obj;
        if([cookie.name isEqualToString:@"userPassword"]){
            NSLog(@"cookie:%@",cookie);
        }
    }];
    
    //cookie login
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://localhost/login/login2.php"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",response);
        NSLog(@"data=%@",[NSJSONSerialization JSONObjectWithData:data options:0 error:0]);
    }] resume];
    
}



//biometrics
-(void)initUI2{
    float version=[UIDevice currentDevice].systemVersion.floatValue;
    if(version > 8.0){
       LAContext *con= [[LAContext alloc] init];
        BOOL can=[con canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:0];
        if(can){
            
            [con evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"input" reply:^(BOOL success, NSError *error) {
                if(success){
                    NSLog(@"authenticate success");
                }else{
                    NSLog(@"authenticate fail");
                }
            }];
            
        }else{
            NSLog(@"your device do not support boimetrics");
        }
        
        
    }
}


//keychain
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString *name=@"yf";
    NSString *pwd=@"123";
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:key];
    
    //set
    [SSKeychain setPassword:pwd forService:[[NSBundle mainBundle] bundleIdentifier] account:name];
    
    
    //get
      NSLog(@"%@",[SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:[[NSUserDefaults standardUserDefaults] objectForKey:key]]);
}



@end
