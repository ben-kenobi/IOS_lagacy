//
//  AppModViewNib.h
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppMod;

@interface AppModViewNib : UIView
@property (nonatomic,strong) AppMod *mod;
-(void)setMod:(AppMod *)mod andFrame:(CGRect)frame andMainV:(UIView *)mainV;

@end
