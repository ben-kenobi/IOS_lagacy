//
//  YFDiscSub02VC.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDiscSub02VC.h"
#import "Masonry.h"

@interface YFDiscSub02VC ()
@property (nonatomic,weak)UIImageView *iv;


@end

@implementation YFDiscSub02VC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    self.view.layer.contents =(__bridge id)[[UIImage imageNamed:@"luck_entry_background"]CGImage];
    UIImageView *iv=[[UIImageView alloc] init];
    NSMutableArray *ary=[NSMutableArray array];
    for(int i=0;i<2;i++){
        [ary addObject: [UIImage imageNamed:[NSString stringWithFormat:@"lucky_entry_light%d",i]]];
    }
    [iv setAnimationImages:ary];
    [iv setAnimationDuration:.5];
    [iv startAnimating];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@44);
    }];
    
    NSString *imgs[]={@"luck_entry_birthday_button_normal",@"luck_entry_lots_button_normal",@"luck_entry_number_button_normal",@"luck_entry_roulette_button_normal"};
    for(int i=0;i<4;i++){
        UIButton *btn=[[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i%2)
                make.leading.equalTo(self.view.mas_centerX).offset(10);
            else
                make.right.equalTo(self.view.mas_centerX).offset(-10);
            if(i/2)
                make.top.equalTo(self.view.mas_centerY).offset(10);
            else
                make.bottom.equalTo(self.view.mas_centerY).offset(-10);
        }];
    }
    
    
    
}

@end








