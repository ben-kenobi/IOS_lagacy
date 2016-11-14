//
//  UIViewController+Ex.h
//  day26-alipay
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#define iVCKey "curVC"
@interface UIViewController (Ex)
+(void)pushVC:(UIViewController *)vc;
+(void)popVC;
+(void)setVC:(UIViewController *)vc;
@end
