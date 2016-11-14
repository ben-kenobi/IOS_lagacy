//
//  YFCatePopVC.h
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFCategory;
@interface YFCatePopVC : UIViewController
@property (nonatomic,copy)void (^onchange)(YFCategory *cate,NSInteger subrow);

@end
