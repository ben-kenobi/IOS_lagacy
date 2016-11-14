//
//  MainVC.m
//  day36-push
//
//  Created by apple on 15/11/15.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "MainVC.h"
static NSInteger i=1;
@interface MainVC ()

@end

@implementation MainVC


//local notification
- (void)viewDidLoad {
    [super viewDidLoad];
    
   //cate01
    UIMutableUserNotificationCategory *cate=[[UIMutableUserNotificationCategory alloc] init];
    cate.identifier=@"useriden";
    
    
    UIMutableUserNotificationAction *action=[[UIMutableUserNotificationAction alloc] init];
    action.title=@"123";
    action.identifier=@"action1";
    action.activationMode=UIUserNotificationActivationModeBackground;
    
    UIMutableUserNotificationAction *action2=[[UIMutableUserNotificationAction alloc] init];
    action2.identifier=@"action2";
    action2.title=@"e12e";
    action2.destructive=YES;
    
    [cate setActions:@[action,action2] forContext:UIUserNotificationActionContextDefault];

    
    //cate02
    UIMutableUserNotificationCategory *cate2=[[UIMutableUserNotificationCategory alloc] init];
    cate2.identifier=@"useriden2";
    
    
    UIMutableUserNotificationAction *action20=[[UIMutableUserNotificationAction alloc] init];
    action20.title=@"-action20";
    action20.identifier=@"action1";
    action20.activationMode=UIUserNotificationActivationModeBackground;
    
    UIMutableUserNotificationAction *action21=[[UIMutableUserNotificationAction alloc] init];
    action21.identifier=@"action2";
    action21.title=@"-action21";
    action21.destructive=YES;
    
    UIMutableUserNotificationAction *action22=[[UIMutableUserNotificationAction alloc] init];
    action22.identifier=@"action3";
    action22.title=@"-action22";
    action22.destructive=YES;
    
    UIMutableUserNotificationAction *action23=[[UIMutableUserNotificationAction alloc] init];
    action23.identifier=@"action4";
    action23.title=@"-action23";
    action23.destructive=YES;
    
    [cate2 setActions:@[action20,action21,action22,action23] forContext:UIUserNotificationActionContextMinimal];

    [iApp registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObjects:cate,cate2, nil]]];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setBackgroundColor:[UIColor randomColor]];
    
    UILocalNotification *local=[[UILocalNotification alloc] init];
    local.fireDate=[NSDate dateWithTimeIntervalSinceNow:5];
    local.alertBody=[NSString stringWithFormat:@"notificateiontest%ld",i];
    local.applicationIconBadgeNumber=i++;
    [local setSoundName:UILocalNotificationDefaultSoundName];
//    local.hasAction=YES;
//    local.alertAction=@"test";
     [local setCategory:@"useriden2"];

    [iApp scheduleLocalNotification:local];
   
}


@end
