//
//  YFFriendF.h
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@class YFFriend;

@interface YFFriendF : NSObject
@property (nonatomic,assign,readonly)CGRect iconF;
@property (nonatomic,assign,readonly)CGRect nameF;
@property (nonatomic,assign,readonly)CGRect introF;
@property (nonatomic,assign,readonly)CGFloat heigth;

@property (nonatomic,strong)YFFriend *fri;


+(instancetype)fWithFri:(YFFriend *)fri;
@end
