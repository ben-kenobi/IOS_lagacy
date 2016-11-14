//
//  TouchIDVC.m
//  day53-msgNfaceNcloud
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "TouchIDVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDVC ()

@end

@implementation TouchIDVC

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(iVersion >= 8.0){
        LAContext *con = [[LAContext alloc] init];
        if([con canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]){
            [con evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"owner ID authenticate" reply:^(BOOL success, NSError * _Nullable error) {
                if(error) {
                    NSLog([self errorInfo:error]);
                }else if(success){
                    NSLog(@"ID confirmed");
                }
            }];
        }else{
            NSLog(@"unsupported device or Biometrics disabled");
        }
    }else{
        NSLog(@"unsupported system version");
    }
}

-(NSString *)errorInfo:(NSError *)error{
    NSString *msg = nil;
    
    NSLog(@"error: %@",error.userInfo[NSLocalizedDescriptionKey]);
    
    NSString *errorStr = error.userInfo[NSLocalizedDescriptionKey];
    
    if ([errorStr containsString:@"Canceled by user"]) {
       msg=@"Canceled by user";
    }
    
    if ([errorStr containsString:@"Application retry limit exceeded"]) {
         msg=@"2 limit left";
    }
    
    if ([errorStr containsString:@"Biometry is locked out"]) {
        msg=@"fail 5 times,boimetry locked out,please input your pwd instead";
    }
    return msg;

//
//    if(error.code == -2){
//        return @"user cancelled";
//    }else{
//        return @"authentication error";
//    }

}

@end
