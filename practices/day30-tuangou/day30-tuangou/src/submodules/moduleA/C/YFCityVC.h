//
//  YFCityVC.h
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCityVC : UIViewController
@property (nonatomic,copy)void (^onchange)(NSString *name);
@end
