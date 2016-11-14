//
//  YFDiscSub03VC.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDiscSub03VC.h"
#import "YFWheel.h"
#import "Masonry.h"

@interface YFDiscSub03VC ()
@property (nonatomic,weak)YFWheel *wheel;

@end

@implementation YFDiscSub03VC


-(void)initUI{
//    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"LuckyBackground"] CGImage];
    YFWheel *wheel=[[YFWheel alloc] init];
    [self.view addSubview:wheel];
    self.wheel=wheel;
    [wheel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(self.view.mas_width);
        make.center.equalTo(@0);
    }];
    
    [wheel setBackgroundColor:[UIColor blackColor]];
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
@end
