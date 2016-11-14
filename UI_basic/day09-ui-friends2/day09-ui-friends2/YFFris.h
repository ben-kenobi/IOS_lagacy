//
//  YFFris.h
//  day09-ui-friends2
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFFris : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger online;
@property (nonatomic,strong)NSMutableArray *friends;
@property (nonatomic,assign,getter=isOpen)BOOL open;

+(instancetype)frisWithDict:(NSDictionary *)dict;
@end
