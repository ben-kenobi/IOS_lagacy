//
//  YFMainNavVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainNavVC.h"
#import "YFHomeVC.h"

@interface YFMainNavVC ()

@end

@implementation YFMainNavVC


-(instancetype)init{
    if(self=[super initWithRootViewController:[[YFHomeVC alloc] init]]){
        [UIViewController setVC:self];
    }
    return self;
}


@end
