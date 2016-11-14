//
//  YFToolPad.h
//  day18-ui-gesture
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFToolPad : UIView

@property (nonatomic,weak)UIButton *curBtn;
@property (nonatomic,weak)UISlider *slider;

@property (nonatomic,copy)void (^colorChange)();

@end
