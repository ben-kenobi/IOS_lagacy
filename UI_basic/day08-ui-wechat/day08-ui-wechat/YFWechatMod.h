//
//  YFWechatMod.h
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ChatType_ME=0,
    ChatTYpe_O=1
}ChatType;


@interface YFWechatMod : NSObject

@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,assign)ChatType type;
@property (nonatomic,assign,getter=isShowTime) BOOL showTime;

+(instancetype)modWithDict:(NSDictionary *)dict lastTime:(NSString *)lastTime;

@end
