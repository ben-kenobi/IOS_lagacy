//
//  LuckyNumCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "LuckyNumCon.h"

#import "Masonry.h"

@interface LuckyNumCon()

@property (nonatomic,weak)UIImageView *iv;

@property (nonatomic,strong)NSMutableArray *btns;
@end

@implementation LuckyNumCon

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)initUI{
    self.view.layer.contents=(__bridge id)[[UIImage imageNamed:@"luck_entry_background"]CGImage];

    UIImageView *iv=[[UIImageView alloc] init];
    iv.animationImages=@[[UIImage imageNamed:@"lucky_entry_light0"],[UIImage imageNamed:@"lucky_entry_light1"]];
    self.iv=iv;
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@44);
    }];
    [iv setAnimationRepeatCount:0];
    [iv setAnimationDuration:.5];
    [iv startAnimating];
    
    
    UIButton *btn;
    for(int i=0;i<4;i++){
        btn=[[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"luck_entry_birthday_button_normal"] forState:UIControlStateNormal];
        btn.bounds=(CGRect){0,0,[UIImage imageNamed:@"luck_entry_birthday_button_normal"].size};
        [self.view addSubview:btn];
        [self.btns addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i%2){
                make.left.equalTo(self.view.mas_centerX).offset(10);
            }else{
                make.right.equalTo(self.view.mas_centerX).offset(-10);
            }
            
            if(i/2){
                make.top.equalTo(self.view.mas_centerY).offset(20);
            }else{
                make.bottom.equalTo(self.view.mas_centerY).offset(-20);
            }
        }];
        
    }
    
}

-(NSMutableArray *)btns{
    if(!_btns){
        _btns=[NSMutableArray array];
    }
    return _btns;
}


@end
