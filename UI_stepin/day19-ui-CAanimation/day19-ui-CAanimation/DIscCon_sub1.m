//
//  DIscCon_sub1.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "DIscCon_sub1.h"
#import "YFButton.h"
#import "UIColor+Extension.h"
#import "UIView+Ex.h"
@interface DIscCon_sub1 ()

@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,weak)UIView *curtain;
@property (nonatomic,assign)BOOL showCurtain;

@end

@implementation DIscCon_sub1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}
-(void)initUI{
    [self.view setBackgroundColor:[UIColor redColor]] ;
    
    UIButton *btn=[[YFButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    self.navigationItem.titleView=btn;
    self.btn=btn;
    [btn sizeToFit];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.btn){
        self.showCurtain=!_showCurtain;
        [self curtain];
    }
    
    
    
    
    
}

-(UIView *)curtain{
    if(!_curtain){
        UIView *curtain=[[UIView alloc] init];
        [self.view addSubview:curtain];
        [curtain setBackgroundColor:[UIColor randomColor]];
        self.curtain=curtain;
        curtain.bounds=(CGRect){0,0,self.view.w,self.view.h*.6};
        curtain.x=0;curtain.y=-curtain.h;
    }
    
    [UIView animateWithDuration:.1 animations:^{
        self.btn.imageView.transform=_showCurtain? CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:.5 animations:^{
        _curtain.y=_showCurtain?0:-_curtain.h;
    }];
    
    return _curtain;
}





@end
