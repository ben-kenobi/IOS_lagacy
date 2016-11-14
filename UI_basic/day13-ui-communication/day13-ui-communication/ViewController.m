//
//  ViewController.m
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MBProgressHUD+ZJ.h"
#import "ListController.h"

@interface ViewController ()

@property (nonatomic,weak)UITextField *username;
@property (nonatomic,weak)UITextField *pwd;
@property (nonatomic,weak)UIButton *login;
@property (nonatomic,weak)UISwitch *rem;
@property (nonatomic,weak)UISwitch *autologin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initState];
    [self initListeners];
    
}

-(void)initState{
    [self loadPref];
    [self onTfChange:nil];
}
-(void)initListeners{
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.username];
     [nc addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.pwd];
    SEL onbtnclick=NSSelectorFromString(@"onBtnClicked:");
    [self.login addTarget:self action:onbtnclick forControlEvents:UIControlEventTouchUpInside];
    [self.autologin addTarget:self action:onbtnclick forControlEvents:UIControlEventValueChanged];
    [self.rem addTarget:self action:onbtnclick forControlEvents:UIControlEventValueChanged];
}



-(void)onBtnClicked:(id)sender{
    if(sender==self.login){
        NSString *username=self.username.text;
        NSString *pwd=self.pwd.text;
        [MBProgressHUD  showMessage:@"login..."];
        dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            if([username isEqualToString:@"1"]&&[pwd isEqualToString:@"1"]){
                ListController *lc=[[ListController alloc] init];
                lc.title=username;
                [self.navigationController showViewController:lc sender:@"123"];
                [self savePref];
            }else{
                [MBProgressHUD showError:@"wrong username or password"];
            }
            
        });
    }else if(sender==self.rem){
        if(!self.rem.on)
            self.autologin.on=NO;
    }else if(sender==self.autologin){
        if(self.autologin.on)
            self.rem.on=YES;
    }
}

-(void)savePref{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setBool:self.rem.on forKey:@"rem"];
    [ud setBool:self.autologin.on forKey:@"autologin"];
    [ud setObject:self.username.text forKey:@"username"];
    [ud setObject:self.pwd.text forKey:@"pwd"];
    [ud synchronize];
}
-(void)loadPref{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    self.rem.on=[ud boolForKey:@"rem"];
    self.autologin.on=[ud boolForKey:@"autologin"];
    self.username.text=[ud objectForKey:@"username"];
    if (self.rem.on) {
        self.pwd.text=[ud objectForKey:@"pwd"];
    }
    if(self.autologin.on){
        [self performSelector:@selector(onBtnClicked:) withObject:self.login afterDelay:.2];
    }
}

-(void)onTfChange:(NSNotification *)noti{
    self.login.enabled=self.pwd.text.length&&self.username.text.length;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initUI{
    self.title=@"login";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITextField *username=[[UITextField alloc] init];
    self.username =username;
    [self.view addSubview:username];
    [username setBorderStyle:UITextBorderStyleRoundedRect];
    [username setPlaceholder:@"username"];
    [username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
    
    }];
    
    UITextField *pwd=[[UITextField alloc] init];
    self.pwd=pwd;
    [self.view addSubview:pwd];
    [pwd setPlaceholder:@"password"];
    [pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(username);
        make.top.equalTo(username.mas_bottom).offset(20);
    }];
    [pwd setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    UILabel *(^newlab)(NSString*,UIView *)=^(NSString *text,UIView *supv){
        UILabel *lab=[[UILabel alloc] init];
        lab.text=text;
        lab.font=[UIFont systemFontOfSize:14];
        [lab setTextColor:[UIColor blackColor]];
        [supv addSubview:lab];
        return lab;
    };
    
    UILabel *remlab=newlab(@"记住密码",self.view);
    [remlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(pwd);
        make.top.equalTo(pwd.mas_bottom).offset(20);
    }];
    
    
    UISwitch *rem=[[UISwitch alloc] init];
    self.rem=rem;
    [self.view addSubview:rem];
    [rem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(remlab.mas_trailing).offset(5);
        make.centerY.equalTo(remlab);
    }];
    
    UISwitch *autologin=[[UISwitch alloc] init];
    self.autologin=autologin;
    [self.view addSubview:autologin];
    [autologin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(pwd);
        make.centerY.equalTo(rem);
    }];
    
    UILabel *autolab=newlab(@"自动登录",self.view);
    [autolab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(autologin.mas_leading).offset(-5);
        make.centerY.equalTo(autologin);
    }];
    
    
    
    
    
    UIButton *login=[[UIButton alloc] init];
    self.login=login;
    [self.view addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    [login setTitle:@"login" forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor orangeColor]];
    [login setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [login setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}



-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
