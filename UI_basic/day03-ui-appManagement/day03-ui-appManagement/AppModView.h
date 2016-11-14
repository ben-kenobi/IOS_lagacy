//
//  AppModView.h
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppMod;
@interface AppModView : UIView
@property (nonatomic,strong) AppMod *mod;
+(instancetype)modViewWithMod:(AppMod *)mod frame:(CGRect)frame mainV:(UIView *)mainV;

@end
