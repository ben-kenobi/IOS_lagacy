//
//  YFWechatMod.h
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    WechatTYpe_ME=0,
    WechatType_O=1
}WechatType;
@interface YFWechatMod : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign)WechatType type;
@property (nonatomic,assign,getter=isHideTime) BOOL hideTime;

+(instancetype)modWithDict:(NSDictionary *)dict lastTime:(NSString *)lastTime;

@end
