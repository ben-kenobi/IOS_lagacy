//
//  YFTopItem.h
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTopItem : UIView

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *subtitle;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,copy)void(^onClick)(id sender);
@end
