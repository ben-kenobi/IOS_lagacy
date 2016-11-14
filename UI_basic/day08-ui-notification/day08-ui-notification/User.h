//
//  User.h
//  day08-ui-notification
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,copy)NSString *name;
+(instancetype)userWithName:(NSString *)name;

-(void)receive:(NSNotification *)noti;
@end
