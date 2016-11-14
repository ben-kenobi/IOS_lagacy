//
//  YFChatMod.h
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
   ChatType_ME,
    ChatType_O
}ChatType;

@interface YFChatMod : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,assign)ChatType type;
@property (nonatomic,assign,getter=isHideTime) BOOL hideTime;

+(instancetype)modWithDict:(NSDictionary *)dict;

@end
