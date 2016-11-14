//
//  QFXIBViewController.h
//  TestLoadViewCycle
//
//  Created by qianfeng on 14-7-10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

/*
 使用 XIB 注意
 
 XIB的名称推荐与VC名称一致，这样在没有指定 XIB 初始化VC（QFXIBViewController *qfxibvc = [[QFXIBViewController alloc] init]）时，系统会优先查找是否有同名XIB 用于 VC 的初始化
 
 initWithNibName: 保存了 用于初始化的 XIB 名称，在创建self.view时才根据保存的 XIB名称 去寻找对应的 XIB 文件
 
 */

#import <UIKit/UIKit.h>

@interface QFXIBViewController : UIViewController

@end
