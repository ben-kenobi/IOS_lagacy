//
//  YFWechatF.h
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFWechatMod;

@interface YFWechatF : NSObject

@property (nonatomic,assign)CGRect iconF;
@property (nonatomic,assign)CGRect timeF;
@property (nonatomic,assign)CGRect textF;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,strong)YFWechatMod *mod;


+(instancetype)fWithMod:(YFWechatMod *)mod;
@end
