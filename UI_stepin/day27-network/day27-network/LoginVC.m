//
//  LoginVC.m
//  day27-network
//
//  Created by apple on 15/11/1.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "LoginVC.h"
#import "NSString+Hash.h"
#import "MBProgressHUD+ZJ.h"
#import <LocalAuthentication/LocalAuthentication.h>



@interface LoginVC ()
@property (nonatomic,weak)UITextField *username;
@property (nonatomic,weak)UITextField *pwd;
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UISwitch *sw;
@end

@implementation LoginVC

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
            [MBProgressHUD showSuccess:@"login..."];
            NSString *key=@"8a627a4578ace384017c997f12d68b23";
            NSString *encryptedPwd=[self timeBaseString:pwd WithKey:key];

             NSString *str=   [@"http://%2545loc空间看alhost/login/loginhmac.php" stringByAddingPercentEscapesUsingEncoding:4];
            NSLog(@"%@",str);
            NSMutableURLRequest *mreq=[NSMutableURLRequest requestWithURL:iURL(@"http://localhost/login/loginhmac.php") cachePolicy:1 timeoutInterval:5];
            mreq.HTTPBody=[[NSString stringWithFormat:@"username=%@&password=%@",username,encryptedPwd] dataUsingEncoding:4] ;
            mreq.HTTPMethod=@"POST";
            [[[NSURLSession sharedSession] dataTaskWithRequest:mreq completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                if(data&&!error){
                    NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                        if([dict[@"userId"] intValue]==1){
                            [IUtil broadcast:LoginNoti info:@{pwdkey:encryptedPwd,usernamekey:username}];
                        }else{
                            [MBProgressHUD showError:@"wrong pwd or username"];
                            
                        }
                    });
                }
                
                
                
            }] resume];
            
        }else{
            [self LAContextLogin];
        }
    }
}

-(NSString *)timeBaseString:(NSString *)str WithKey:(NSString *)key{
    NSDateFormatter *fm=[[NSDateFormatter alloc] init];
    fm.dateFormat=@"yyyy-MM-dd HH:mm";
    NSString *time=[fm stringFromDate:[NSDate date]];
    str=[[str hmacMD5StringWithKey:key] stringByAppendingString:time];
    return [str hmacMD5StringWithKey:key];
}


-(void)loadUserInfo{
    self.username.text=[iPref(0) objectForKey:usernamekey];
    self.pwd.text=[iPref(0) objectForKey:pwdkey];
}

-(void)LAContextLogin{
    if([IUtil systemVersion]<8.0){
        NSLog(@"system version too old,please upgrade your system");
        return ;
    }
    
    LAContext *con=[[LAContext alloc] init];
    
    if(![con canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:0]){
        NSLog(@"your device do not support biometric");
        return ;
    }
    
    [con evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"biometric login" reply:^(BOOL success, NSError *error) {
        if(success){
            NSLog(@"login success");
        }else{
            NSLog(@"login fail");
        }
    }];
}


@end
