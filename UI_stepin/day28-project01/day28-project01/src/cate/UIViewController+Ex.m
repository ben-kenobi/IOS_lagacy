//
//  UIViewController+Ex.m
//  day26-alipay
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIViewController+Ex.h"
#import "objc/runtime.h"


@implementation UIViewController (Ex)
+(void)pushVC:(UIViewController *)vc{
    [[objc_getAssociatedObject(iApp, iVCKey) navigationController] pushViewController:vc animated:YES];
}

+(void)popVC{
    [[objc_getAssociatedObject(iApp, iVCKey) navigationController] popViewControllerAnimated:YES];
}
@end
