//
//  CoverViewCode.h
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppMod;

@interface CoverViewCode : UIView

@property (nonatomic,strong) AppMod *mod;
@property(nonatomic,strong) UILabel *lab;
+(instancetype)viewWithFrame:(CGRect)frame andMod:(AppMod *)mod;

@end
