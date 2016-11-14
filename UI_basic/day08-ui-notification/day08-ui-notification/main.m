//
//  main.m
//  day08-ui-notification
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Company.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        User *user1=[User userWithName:@"jack"];
        User *user2=[User userWithName:@"tom"];
        User *user3=[User userWithName:@"frank"];
        
        Company *com1=[Company comWithName:@"tencent"];
        Company *com2=[Company comWithName:@"baidu"];
        
        
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        
     
        [center addObserver:user2 selector:@selector(receive:) name:@"" object:com1];
       
        
        [center removeObserver:user2 name:@"" object:com1];
        
        [center postNotificationName:@"" object:com1 userInfo:@{@"title":@"newstitle1",@"content":@"newscontent1"}];
        
        
        
        
    }
    return 0;
}
