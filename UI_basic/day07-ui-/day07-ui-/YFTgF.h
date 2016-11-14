//
//  YFTgF.h
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFTg;
@interface YFTgF : NSObject

@property (nonatomic,strong)YFTg *tg;
@property (nonatomic,assign)CGRect iconF;
@property (nonatomic,assign)CGRect titleF;
@property (nonatomic,assign)CGRect priceF;
@property (nonatomic,assign)CGRect buyCountF;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat wid;

+(instancetype)tgfWithTg:(YFTg *)tg wid:(CGFloat)wid;

@end
