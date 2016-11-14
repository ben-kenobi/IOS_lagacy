//
//  YFApp.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFApp : NSObject
@property (nonatomic,copy)NSString *size;
@property (nonatomic,copy)NSString *download;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;

@property (nonatomic,assign)BOOL downloaded;

+(instancetype)appWithDict:(NSDictionary *)dict;

@end
