

//
//  MsgValiVC.m
//  day53-msgNfaceNcloud
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "MsgValiVC.h"
#import <SMS_SDK/SMS_SDK.h>
#import "SVProgressHUD.h"

@interface MsgValiVC ()
@property (nonatomic,strong)UITextField *phonenum;
@property (nonatomic,strong)UITextField *valicode;
@property (nonatomic,strong)UIButton *getCode;
@property (nonatomic,strong)UIButton *validate;
@end

@implementation MsgValiVC

- (void)viewDidLoad {
    [super viewDidLoad];
   [SMS_SDK registerApp:@"918ace854766" withSecret:@"ac7a4156bdf2535d1167b24dc5a42e6a"];
    
    [self initUI];
    
    
    
    
}


-(void)onbClick:(UIButton *)sender{
    if(sender == self.getCode){
        [SVProgressHUD showWithStatus:@"send valicode" maskType:SVProgressHUDMaskTypeBlack];
        [SMS_SDK getVerificationCodeBySMSWithPhone:self.phonenum.text zone:@"86" result:^(SMS_SDKError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:error ? @"failure":@"success" maskType:SVProgressHUDMaskTypeBlack];
        }];
    }else if(sender==self.validate){
        [SMS_SDK commitVerifyCode:self.valicode.text result:^(enum SMS_ResponseState state) {
            if(state== SMS_ResponseStateFail){
                NSLog(@"failure");
            }else if(state==SMS_ResponseStateSuccess) {
                NSLog(@"sucess");
            }
        }];
    }
}


-(void)initUI{
    self.view.backgroundColor=[UIColor orangeColor];
    UITextField *(^newtf)(NSString *)=^(NSString *ph){
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = ph;
        [self.view addSubview:tf];
        tf.layer.cornerRadius=8;
        tf.layer.borderColor=[UIColor grayColor].CGColor;
        tf.layer.borderWidth=1;
        tf.leftView=[[UIView alloc] initWithFrame:(CGRect){0,0,10,0}];
        tf.leftViewMode=UITextFieldViewModeAlways;
        return tf;
    };
    
    UIButton *(^newb)(NSString *)=^(NSString *title){
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:title forState:0];
        [self.view addSubview:b];
        b.titleLabel.font=iBFont(22);
        [b addTarget:self action:@selector(onbClick:) forControlEvents:UIControlEventTouchUpInside];
        return b ;
    };
    self.phonenum = newtf(@"phone num");
    self.valicode = newtf(@"valiCode");
    
    [self.phonenum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@100);
        make.height.equalTo(@44);
        make.width.equalTo(self.view.mas_width).multipliedBy(.7);
        
    }];
    
    [self.valicode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.phonenum).offset(150);
        make.height.equalTo(@44);
        make.width.equalTo(self.view.mas_width).multipliedBy(.7);
        
    }];
    
    
    self.getCode = newb(@"get valicode");
    self.validate  = newb(@"commit valicode");
    [self.getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.phonenum.mas_bottom).offset(20);
    }];
    
    [self.validate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.valicode.mas_bottom).offset(20);
    }];
}

@end
