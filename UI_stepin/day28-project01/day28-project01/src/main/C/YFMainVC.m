//
//  YFMainVC.m
//  day28-project01
//
//  Created by apple on 15/10/30.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainVC.h"
#import "YFRootVC.h"

@interface YFMainVC ()

@end

@implementation YFMainVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(instancetype)init{
    if(self = [super initWithRootViewController:[[YFRootVC alloc]init]]){

    }
    return self;
}

@end
