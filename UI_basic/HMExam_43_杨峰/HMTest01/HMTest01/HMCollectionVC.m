//
//  HMCollectionVC.m
//  HMTest01
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMCollectionVC.h"
#import "HMSV.h"
#import "YFCate.h"

@interface HMCollectionVC ()

@property (nonatomic,weak)HMSV *sv;
@property (nonatomic,weak)UIButton *btn;


@end

@implementation HMCollectionVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title=@"栏目排序";
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setTitle:@"添加栏目" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    self.btn=btn;
    [btn setBackgroundColor:[UIColor redColor]];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(@0);
    }];
    
    
    
    HMSV *sv=[[HMSV alloc] initWithCellCount:9];
    [self.view addSubview:sv];
    self.sv=sv;

    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(btn.mas_bottom).offset(5);
    }];
    [btn addTarget:self.sv action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
}


@end
