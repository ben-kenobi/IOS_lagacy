//
//  PlayerViewController.m
//  01-仿酷我音乐
//
//  Created by 刘凡 on 15/11/11.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)loadView {
    self.view = [[UIView alloc] init];
    
    // 设置定位点
    self.view.layer.anchorPoint = CGPointMake(0.5, 1.0);

    // 设置背景颜色
    self.view.backgroundColor = [UIColor blueColor];
    // 设置视图大小
    self.view.frame = [UIScreen mainScreen].bounds;
    
    // 添加手势识别
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint point = [recognizer translationInView:self.view];
    
    CGAffineTransform transform = self.view.transform;
    
    // 判断手势的状态
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        NSLog(@"%@", NSStringFromCGAffineTransform(transform));
        
        // 根据 transform 的 b 值判断是否 dismiss
        if (ABS(transform.b) > 0.25) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // 恢复视图的位置
            [UIView animateWithDuration:0.25
                                  delay:0.0
                 usingSpringWithDamping:0.8
                  initialSpringVelocity:10
                                options:0
                             animations:^{
                                 self.view.transform = CGAffineTransformIdentity;
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat viewAngle = atan2(transform.b, transform.a);
        
        CGFloat dx = point.x * cos(viewAngle);
        CGFloat dy = point.y * sin(viewAngle);
        
        CGFloat angle = (dx + dy) / self.view.bounds.size.width;
        
        // 倾斜视图
        transform = CGAffineTransformRotate(transform, angle);
        // 平移视图
        transform.tx += 2 * (dx + dy);
        
        self.view.transform = transform;
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
}

@end
