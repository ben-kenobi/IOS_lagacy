//
//  YFChatF.h
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFChatMod;

@interface YFChatF : UIView

@property (nonatomic,assign,readonly)CGRect iconF;
@property (nonatomic,assign,readonly)CGRect textF;
@property (nonatomic,assign,readonly)CGRect timeF;
@property (nonatomic,assign,readonly)CGFloat height;
@property (nonatomic,assign)CGFloat wid;

@property (nonatomic,strong)YFChatMod *mod;

+(instancetype)charFWithMod:(YFChatMod *)mod wid:(CGFloat)wid;


@end
