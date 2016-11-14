//
//  UIBarButtonItem+Ex.h
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Ex)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action img:(UIImage *)img hlimg:(UIImage *)hlimg;
@end
