//
//  UIBarButtonItem+Ex.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UIBarButtonItem+Ex.h"

@implementation UIBarButtonItem (Ex)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action img:(UIImage *)img hlimg:(UIImage *)hlimg{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:hlimg forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
