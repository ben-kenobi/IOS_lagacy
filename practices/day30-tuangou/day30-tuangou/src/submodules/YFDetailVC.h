//
//  YFDetailVC.h
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  TFDeal;
@interface YFDetailVC : UIViewController
@property (nonatomic,strong)TFDeal *deal;
@property (nonatomic,copy)void (^onCollectChange)(NSMutableDictionary *dict);
@end
