//
//  VC04.m
//  day27-network
//
//  Created by apple on 15/11/1.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "VC04.h"
#import "NSString+Hash.h"
#import "HomeVC.h"



@interface VC04 ()

@property (nonatomic,weak)UITextField *username;
@property (nonatomic,weak)UITextField *pwd;
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UISwitch *sw;

@end

@implementation VC04

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor randomColor]];
    UITextField  *username=[[UITextField alloc] initWithFrame:(CGRect){30,30,200,30}];
    username.cx=self.view.cx;
    [username setBorderStyle:UITextBorderStyleRoundedRect];
    username.placeholder=@"username";
    [self.view addSubview:username];
    self.username=username;

    UITextField  *pwd=[[UITextField alloc] initWithFrame:(CGRect){30,80,200,30}];
    pwd.cx=self.view.cx;
    pwd.placeholder=@"password";
    [self.view addSubview:pwd];
    [pwd setBorderStyle:UITextBorderStyleRoundedRect];
    self.pwd=pwd;
    [pwd setSecureTextEntry:YES];
    
    UILabel *lab=[[UILabel alloc] init];
    lab.text=@"记住密码";
    [lab sizeToFit ];
    lab.frame=(CGRect){120,120,lab.size};
    [self.view addSubview:lab];
    
    UISwitch *sw=[[UISwitch alloc] init];
    [self.view addSubview:sw];
    sw.frame=(CGRect){120+lab.w+5,120,sw.size};
    self.sw=sw;
    
    UIButton *btn=[[UIButton alloc] init];
    [self.view addSubview:btn];
    self.btn=btn;
    [btn setTitle:@"login" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor randomColor]];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.frame=(CGRect){0,200,200,44};
    btn.cx=self.view.cx;
    
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self loadUserInfo];
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.btn){
        NSString *username=self.username.text;
        NSString *pwd=self.pwd.text;
        if(username.length&&pwd.length){
            
            NSString *key=@"8a627a4578ace384017c997f12d68b23";
            pwd= [pwd hmacMD5StringWithKey:key];
            NSDateFormatter *fm=[[NSDateFormatter alloc] init];
            fm.dateFormat=@"yyyy-MM-dd HH:mm";
            NSString *time=[fm stringFromDate:[NSDate date]];
            pwd=[[pwd stringByAppendingString:time] hmacMD5StringWithKey:key];


            
            NSMutableURLRequest *mreq=[NSMutableURLRequest requestWithURL:iURL(@"http://localhost/login/loginhmac.php") cachePolicy:1 timeoutInterval:5];
            mreq.HTTPBody=[[NSString stringWithFormat:@"username=%@&password=%@",username,pwd] dataUsingEncoding:4] ;
            mreq.HTTPMethod=@"POST";
            [[[NSURLSession sharedSession] dataTaskWithRequest:mreq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                if(data&&!error){
                   NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:data options:0 error:0];

                    if([dict[@"userId"] intValue]==1){
                        [iPref(0) setObject:username forKey:usernamekey];
                        [iPref(0) setObject:pwd forKey:pwdkey];
                        [iPref(0) synchronize];
                    }else{
                        NSLog(@"wrong");
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            HomeVC *vc=[[HomeVC alloc] init];
                            [vc setModalTransitionStyle:UIModalTransitionStylePartialCurl];
                            [self showViewController:vc sender:0];
                        });
                       
                        
                    }
                }
                
        
            }] resume];
            
        }else{
            
        }
    }
}

-(void)loadUserInfo{
    self.username.text=[iPref(0) objectForKey:usernamekey];
    self.pwd.text=[iPref(0) objectForKey:pwdkey];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
    
//    NSMutableURLRequest *mreq=[NSMutableURLRequest requestWithURL:iURL(@"http://localhost/login/login.php") cachePolicy:1 timeoutInterval:5];
//    mreq.HTTPBody=[[NSString stringWithFormat:@"username=%@&password=%@",self.username.text,self.pwd.text] dataUsingEncoding:4] ;
//    mreq.HTTPMethod=@"POST";
//    [[[NSURLSession sharedSession] dataTaskWithRequest:mreq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@----%@",response,[[NSString alloc] initWithData:data encoding:4]);
//
//    }] resume];
    
    
//    NSString *str=@"0123331";
//    NSData *data=[str dataUsingEncoding:4];
//    
//     char * bs=(char *)[data bytes];
//    
//    for(NSInteger i=0;i<data.length;i++){
//        char c1=bs[i];
//        for(int i=7;i>=0;i--){
//            printf("%d",(c1>>i)&1);
//        }
//        printf("\n");
//    }
//    printf("\n");
//    
//    NSData *data2=[data base64EncodedDataWithOptions:0];
//    
//    char * bs2=(char *)[data2 bytes];
//    
//    for(NSInteger i=0;i<data2.length;i++){
//        char c1=bs2[i];
//        for(int i=7;i>=0;i--){
//            printf("%d",(c1>>i)&1);
//        }
//        printf("\n");
//    }
//    printf("\n");
//    
//    
//    NSLog(@"\n%@\n%@",data,data2 );

}

@end
