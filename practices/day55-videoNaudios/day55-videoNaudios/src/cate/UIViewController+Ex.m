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
//   id obj= [objc_getAssociatedObject(iApp, iVCKey) navigationController];
    UIViewController * obj=objc_getAssociatedObject(iApp, iVCKey);
    if([obj  isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)obj pushViewController:vc animated:YES];
    }else{
       [ [obj navigationController] pushViewController:vc animated:YES];
    }
}
+(void)setVC:(UIViewController *)vc{
    objc_setAssociatedObject(iApp, iVCKey, vc, OBJC_ASSOCIATION_ASSIGN);
}
+(void)popVC{
    UIViewController *obj=objc_getAssociatedObject(iApp, iVCKey);
    if([obj  isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)obj popViewControllerAnimated:YES];
    }else{
        [ [obj navigationController] popViewControllerAnimated:YES];
    }
}
@end
