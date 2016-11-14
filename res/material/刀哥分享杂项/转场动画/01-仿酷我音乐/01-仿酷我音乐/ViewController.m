//
//  ViewController.m
//  01-仿酷我音乐
//
//  Created by 刘凡 on 15/11/10.
//  Copyright © 2015年 joyios. All rights reserved.
//

#import "ViewController.h"
#import "PlayerViewController.h"
#import "RotateTransitionDelegate.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *demoView;
/// 旋转转场动画代理，提供转场动画的对象
@property (nonatomic, strong) RotateTransitionDelegate *rotateDelegate;
@end

@implementation ViewController

- (RotateTransitionDelegate *)rotateDelegate {
    if (_rotateDelegate == nil) {
        _rotateDelegate = [[RotateTransitionDelegate alloc] init];
    }
    return _rotateDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];

//    self.demoView = [[UIView alloc] init];
//    self.demoView.backgroundColor = [UIColor whiteColor];
//    
//    // 设置定位点，注意：一定要设置完定位点之后，再设置 frame
//    self.demoView.layer.anchorPoint = CGPointMake(0.5, 1.0);
//    // 设置视图位置
//    self.demoView.frame = self.view.bounds;
//    
//    [self.view addSubview:self.demoView];
//
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (![segue.destinationViewController isKindOfClass:[PlayerViewController class]]) {
        return;
    }
    
    // 设置 modal 转场类型
    PlayerViewController *vc = segue.destinationViewController;
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    
    // 设置转场(转换场景)动画代理
    vc.transitioningDelegate = self.rotateDelegate;

    NSLog(@"come here");
}

/// 处理拖动手势
/**
 struct CGAffineTransform {
     CGFloat a, b, c, d;
     CGFloat tx, ty;
 };
 
 tx / ty 处理位移的
 a / d 是处理缩放比例的
 a / b / c / d 共同处理旋转角度的
 */

@end
