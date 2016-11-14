//
//  ViewController.m
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+ZJ.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UISwitch *rem;

@property (weak, nonatomic) IBOutlet UISwitch *autologin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setTitle:self.username.text ];
    
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.login){
        [MBProgressHUD showMessage:@"login..."];
        dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            if([self.pwd.text isEqualToString:@"1"]&&[self.username.text isEqualToString:@"1"]){
                [self performSegueWithIdentifier:@"login" sender:nil];
                [self savePref];
            }else{
                [MBProgressHUD showError:@"wrong password or username"];
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

-(void)onTfChange:(NSNotification *)noti{
    self.login.enabled=self.pwd.text.length&&self.username.text.length;
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
    if(self.rem.on){
        self.pwd.text=[ud objectForKey:@"pwd"];
    }
    
    if(self.autologin.on){
        [self performSelector:@selector(onBtnClicked:) withObject:self.login afterDelay:.2];
    }
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)initUI{
    
}

-(void)initState{
    [self loadPref];
    [self onTfChange:nil];
}



-(void)initListeners{
    [self.login addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.username];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.pwd];
    [self.rem addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventValueChanged];
    [self.autologin addTarget:self  action:@selector(onBtnClicked:) forControlEvents:UIControlEventValueChanged];
}


@end
