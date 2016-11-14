//
//  AppMod.h
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppMod : NSObject
@property (nonatomic,strong)UIImage * img;
@property (nonatomic,copy) NSString *title;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appModWithDict:(NSDictionary *)dict;
@end
