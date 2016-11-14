//
//  YFUnlockVC.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFUnlockVC.h"
#import "YFLockPad.h"
#import "AppDelegate.h"
#import "YFLockV.h"
#import "YFLockV2.h"

static NSString *_pwd=@"0123";


@interface YFUnlockVC ()<UIAlertViewDelegate>

@property (nonatomic,weak)YFLockPad *pad;
@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,weak)YFLockV *lockV;
@property (nonatomic,weak)YFLockV2 *lockV2;
@property (nonatomic,copy)NSString *pwd;
@property (nonatomic,copy)NSString *firstpwd;
@property (nonatomic,weak) UILabel *lab;

@end


@implementation YFUnlockVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI3];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger tag=alertView.tag;
    if(tag==1){
        self.firstpwd=0;
        [self updateUI];
    }else if(tag==2){
        if(buttonIndex==0){
            self.firstpwd=0;
            [self updateUI];
        }else{
            [iPref(0) setObject:self.firstpwd forKey:@"unlockPwd"];
            [iPref(0) synchronize];
            [self updateUI];
        }
    }
}
-(NSString *)pwd{
    if(!_pwd){
        _pwd=[iPref(0) objectForKey:@"unlockPwd"];
    }
    return _pwd;
}

-(void)initUI3{

    [self.view setBackgroundColor:[UIColor randomColor]];
    YFLockV2 *lockV2= [[YFLockV2 alloc] init];
    [lockV2 setBackgroundColor:[UIColor randomColor]];
    [self.view addSubview:lockV2];
    self.lockV2=lockV2;
    [lockV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(self.view.mas_width).multipliedBy(.8);
    }];
    
    [lockV2 setOnLogin:^BOOL(NSString *str) {
        if(!self.pwd){
            if(self.firstpwd){
                if( [str isEqualToString:self.firstpwd]){
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"aler" message:@"pwd set success" delegate:self cancelButtonTitle:@"reset" otherButtonTitles:@"login", nil];
                    aler.tag=2;
                    [aler show];
                    return YES;
                }else{
                    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"aler" message:@"pwd not euqual" delegate:self cancelButtonTitle:@"reset" otherButtonTitles:0, nil];
                    aler.tag=1;
                    [aler show];
                    return NO;
                }
                
            }else{
                self.firstpwd=str;
                [self updateUI];
                return YES;
            }
        }
        
        if([str isEqualToString:self.pwd]){
            [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            CATransition *tran=[CATransition animation];
            tran.type=@"cube";
            tran.duration=.25;
            [self.view.layer addAnimation:tran forKey:nil];
            dispatch_after(dispatch_time(0, .25*1e9), dispatch_get_main_queue(), ^{
                [[iApp keyWindow] setRootViewController:[AppDelegate rootVC:NO] ];
            });
            
            return YES;
        }else{
            return NO;
        }
    } comp:^{
        UIGraphicsBeginImageContext(self.lockV2.size);
        [self.lockV2.layer renderInContext:UIGraphicsGetCurrentContext()];
        self.iv.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }];
    

    
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(lockV2).multipliedBy(.333);
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
    }];
    self.iv=iv;
    
    
    [self updateUI];
    
}
-(void)updateUI{
    if(self.pwd){
        [self.lab removeFromSuperview];
        self.iv.image=0;
    } else{
        self.lab.text=self.firstpwd?@"input again":@"input pwd";
        if(!self.firstpwd)
            self.iv.image=0;
    }
    
}
-(UILabel *)lab{
    if(!_lab){
        UILabel *lab=[[UILabel alloc] init];
        [self.view addSubview:lab];
        self.lab=lab;
        lab.textColor=[UIColor orangeColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.bottom.equalTo(self.lockV2.mas_top).offset(-10);
        }];
    }
    return _lab;
}


-(void)initUI2{
    [self.view setBackgroundColor:[UIColor randomColor]];
    
   YFLockV *lockV= [[YFLockV alloc] init];
    [lockV setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lockV];
    self.lockV=lockV;
    [lockV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(self.view).multipliedBy(.8);
    }];
    [self.lockV setBackgroundColor:[UIColor randomColor]];
    
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(lockV).multipliedBy(.333);
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
    }];
    self.iv=iv;
    
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor randomColor]];

    YFLockPad *pad=[[YFLockPad alloc] init];
    [pad setBackgroundColor:[UIColor clearColor]];
    self.pad=pad;
    [self.view addSubview:pad];
    [pad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(self.view.mas_width).multipliedBy(.8);
    }];
    
    [pad setOnLogin:^BOOL(NSString *pwd) {
        if([pwd isEqualToString:_pwd]){
            [self.view setBackgroundColor:[UIColor whiteColor]];
            [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            CATransition *ta=[[CATransition alloc] init];
            ta.type=@"cube";
            ta.duration=.5;
           
            [self.view.layer addAnimation:ta forKey:nil];
            
            dispatch_after(dispatch_time(0, ta.duration*1e9), dispatch_get_main_queue(), ^{
                [[iApp keyWindow] setRootViewController:[AppDelegate rootVC:NO]];
            });
            
            return YES;
        }else{
            return NO;
        }
            
    } comp:^{
        UIGraphicsBeginImageContext(self.pad.size);
        CGContextRef con=UIGraphicsGetCurrentContext();
        [self.pad.layer renderInContext:con];
        UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.iv.image=img;
    }];
    
    
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(pad).multipliedBy(.333);
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
    }];
    self.iv=iv;
    
    
}

@end
