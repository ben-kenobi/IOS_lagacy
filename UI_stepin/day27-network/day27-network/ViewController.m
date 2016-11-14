//
//  ViewController.m
//  day27-network
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()
@property (nonatomic,weak)UIWebView *webv;
@property (nonatomic,assign)struct sockaddr_in server;
@property (nonatomic,assign)int sid;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
//  NSString *str=  [[NSBundle mainBundle]pathForResource:@"pl.xml" ofType:0];
//  NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",str]];
//   NSURLRequest *request= [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSLog(@"%@\n%@\n%@\n%@",[NSThread currentThread],[[NSString alloc ] initWithData:data encoding:4] ,response,connectionError);
//    }];
//
//    
//    NSLog(@"-------++%@",[NSString stringWithContentsOfFile:str encoding:4 error:nil]);
    
    UIWebView *web=[[UIWebView alloc] initWithFrame:self.view.bounds];
    web.h=self.view.h*.8;
    [self.view addSubview:web];
    self.webv=web;
    

    _server.sin_family=AF_INET;
    _server.sin_addr.s_addr=inet_addr("127.0.0.1");
    _server.sin_port=htons(8090);
    _sid=socket(AF_INET, SOCK_STREAM, 0);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  

    int i=connect(_sid, (const struct sockaddr *)&_server, sizeof(_server));
    NSLog(@"%d",i);
     char * str="aerwer\n";

    ssize_t t= send(_sid, str, strlen(str), 0);
    NSLog(@"%ld",t);
    
//     char buffer[100];
//    
//    while (true) {
//        ssize_t t2=recv(sid, buffer, sizeof(buffer), 0);
//        NSString *str2=  [[NSString alloc] initWithBytes:buffer length:t2 encoding:4];
//        NSLog(@"%@",str2);
//    }
    
    
}



@end
