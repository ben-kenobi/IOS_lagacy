//
//  YFWechatF.h
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class YFWechatMod;

@interface YFWechatF : NSObject

@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect textF;
@property (nonatomic,assign) CGRect timeF;
@property (nonatomic,assign ) CGFloat height;
@property (nonatomic,strong) YFWechatMod *mod;
+(instancetype)fWithMod:(YFWechatMod *)mod;

@end
