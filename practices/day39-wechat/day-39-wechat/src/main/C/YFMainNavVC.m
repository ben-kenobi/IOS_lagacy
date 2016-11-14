

//
//  YFMainNavVC.m
//  day-39-wechat
//
//  Created by apple on 15/11/24.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFMainNavVC.h"
#import "YFMainVC.h"

@interface YFMainNavVC ()

@end

@implementation YFMainNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)init{
    YFMainVC *vc=[[YFMainVC alloc] init];
    if(self=[super initWithRootViewController:vc]){
        
    }
    return self;
}

@end
