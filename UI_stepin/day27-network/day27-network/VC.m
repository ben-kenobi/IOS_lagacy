//
//  VC.m
//  day27-network
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "VC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface VC ()
@property (nonatomic,weak)UITextField *ip;
@property (nonatomic,weak)UITextField *port;
@property (nonatomic,weak)UITextField *senTf;
@property (nonatomic,weak)UITextField *recTf;
@property (nonatomic,weak)UIButton *send;
@property (nonatomic,weak)UIButton *con;
@property (nonatomic,assign)struct sockaddr_in server;
@property (nonatomic,assign)int sid;

@end

@implementation VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.con){
        _sid=socket(AF_INET, SOCK_STREAM, 0 );
        _server.sin_family=AF_INET;
        _server.sin_addr.s_addr=inet_addr("192.168.19.111");
        _server.sin_port=htons(8090);
        int i=connect(_sid, (const struct sockaddr *)&_server, sizeof(_server));
       
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            char buffer[100];
            while(true){
                ssize_t t2=recv(_sid, buffer, sizeof(buffer), 0);
                NSString *str2=  [[NSString alloc] initWithBytes:buffer length:t2 encoding:4];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.recTf.text=str2;
                    NSLog(@"%@",str2);
                });
                
            }
        });
        
        
    }else if(sender==self.send){
//        char *str="GET /1.html HTTP/1.1\r\n"
//        "Host: 127.0.0.1\r\n\r\n";
        char *str=[self.senTf.text UTF8String];
        self.senTf.text=@"";
        long t= send(_sid, str, strlen(str), 0);
        NSLog(@"%ld",t);
    }
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor grayColor]];
    UITextField *ip=[[UITextField alloc] initWithFrame:(CGRect){20,20,100,30}];
    [ip setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:ip];
    self.ip=ip;
    

    UITextField *port=[[UITextField alloc] initWithFrame:(CGRect){140,20,60,30}];
    [port setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:port];
    self.port=port;
    
    UIButton *connet=[[UIButton alloc] initWithFrame:(CGRect){220,20,60,30}];
    [connet setTitle:@"connect" forState:UIControlStateNormal];
    self.con=connet;
    [self.view addSubview:connet];
    [connet addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    

    UITextField *senTf=[[UITextField alloc] initWithFrame:(CGRect){20,70,160,30}];
    [senTf setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:senTf];
    self.senTf=senTf;
    
    UIButton *send=[[UIButton alloc] initWithFrame:(CGRect){220,70,60,30}];
    [send setTitle:@"send" forState:UIControlStateNormal];
    self.send=send;
    [self.view addSubview:send];
    [send addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    UITextField *rec=[[UITextField alloc] initWithFrame:(CGRect){20,120,200,100}];
    [rec setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:rec];
    self.recTf=rec;
    [rec setTextAlignment:NSTextAlignmentLeft];
    
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSURLRequest requestWithURL:<#(NSURL *)#> cachePolicy:<#(NSURLRequestCachePolicy)#> timeoutInterval:<#(NSTimeInterval)#>
//}

@end
