//
//  YFSortVC.h
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFSort;
@interface YFSortVC : UIViewController
@property (nonatomic,copy)void (^onchange)(YFSort *);
@end
