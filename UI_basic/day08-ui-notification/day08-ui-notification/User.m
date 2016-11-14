

//
//  User.m
//  day08-ui-notification
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "User.h"

@implementation User

+(instancetype)userWithName:(NSString *)name{
    User *obj=[[self alloc] init];
    obj.name=name;
    return obj;
}

-(void)receive:(NSNotification *)noti{
    NSLog(@"%@ receive %@ %@,  %@",self.name,noti.name,[noti.object valueForKey:@"name"],
          noti.userInfo);
    
}

@end
