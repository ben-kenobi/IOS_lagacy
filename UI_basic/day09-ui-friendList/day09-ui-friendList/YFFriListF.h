//
//  YFFriListF.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIKit/UIKit.h"
@class YFFriendList;

@interface YFFriListF : NSObject
@property (nonatomic,assign)CGRect nameF;
@property (nonatomic,assign)CGRect onlineF;
@property (nonatomic,assign)CGFloat height;

@property (nonatomic,strong)YFFriendList *frilist;

+(instancetype)fWithFrilist:(YFFriendList *)frilist;


@end
