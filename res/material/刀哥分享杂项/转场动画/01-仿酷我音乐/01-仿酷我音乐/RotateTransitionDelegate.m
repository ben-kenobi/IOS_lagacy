//
//  RotateTransitionDelegate.m
//  01-仿酷我音乐
//
//  Created by 刘凡 on 15/11/11.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "RotateTransitionDelegate.h"

@implementation RotateTransitionDelegate

/// 返回提供 modal 转场动画的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
/// 转场动画的动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

/// 提供详细的转场动画细节
/// 一旦实现了此方法，所有的动画细节需要程序员实现
/**
 - (nullable UIView *)containerView;    容器视图，用来装载目标视图控制器的视图
 
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 容器视图
    UIView *containerView = [transitionContext containerView];
    
    // 目标视图
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // 设置初始形变
    toView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    // 将目标视图添加到容器视图中
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:10
                        options:0
                     animations:^{
                         
                         // 恢复视图的形变
                         toView.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finished) {
                         
                         // 转场动画的末尾必须调用的方法，告诉视图控制器转场动画已经结束，否则系统会一直等待转场动画进行！
                         [transitionContext completeTransition:YES];
                     }];
    
}

@end
