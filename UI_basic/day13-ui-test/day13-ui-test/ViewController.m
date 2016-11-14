//
//  ViewController.m
//  day13-ui-test
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#import "MBProgressHUD+ZJ.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@property (weak, nonatomic) IBOutlet UISwitch *remPwd;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setTitle:self.username.text];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange:(NSNotification *)noti{
    self.login.enabled=_username.text.length&&_pwd.text.length?YES:NO;
}

-(void)onBtnClicked:(id ) sender{
    if(sender==self.login){
        if([_username.text isEqualToString:@"yf"]&&[_pwd.text isEqualToString:@"1"]){
            
            [MBProgressHUD  showMessage:@"login..."];
            
            dispatch_after(dispatch_time(0, .1e9), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [self performSegueWithIdentifier:@"loginsegue" sender:nil];
                [self savePref];
            });
           
        }else{
            [MBProgressHUD showError:@"用户名密码错误"];

        }
    }else if(sender==self.remPwd){
        if(!self.remPwd.on)
            self.autoLogin.on=NO;
    }else if(sender==self.autoLogin){
     if(self.autoLogin.on)
         self.remPwd.on=YES;
    }
}

-(void)initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_username];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_pwd];
    [_login addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.remPwd addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventValueChanged];
    [self.autoLogin addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)savePref{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setBool:self.remPwd.on forKey:@"rem"];
    [ud setBool:self.autoLogin.on forKey:@"autologin"];
    [ud setObject:self.username.text forKey:@"username"];
    [ud setObject:self.pwd.text forKey:@"pwd"];
    [ud synchronize];
}
-(void)loadPref{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    self.remPwd.on=[ud boolForKey:@"rem"];
    self.autoLogin.on=[ud boolForKey:@"autologin"];
    self.username.text=[ud objectForKey:@"username"];
    if(self.remPwd.on)
        self.pwd.text=[ud valueForKey:@"pwd"];
    if(self.autoLogin.on)
       [self performSelector:@selector(onBtnClicked:) withObject:self.login afterDelay:.2];
}
-(void)initUI{
    
}

-(void)initState{
    [self loadPref];
    [self textChange:nil];
}

@end
