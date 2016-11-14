//
//  YFDiscSub01VC.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/17.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDiscSub01VC.h"
#import "YFCate.h"

@interface YFButton1 :UIButton
@end

@interface YFDiscSub01VC ()
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,assign)BOOL show;
@property (nonatomic,weak)UIView *cover;

@end

@implementation YFDiscSub01VC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}


-(void)onBtnClicked:(id)sender{
    if(sender==self.btn){
        self.show=!self.show;
        [self updateUI];
    }
}
-(void)updateUI{
    [UIView animateWithDuration:.25 animations:^{
        self.btn.imageView.transform=_show?CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
        self.cover.transform=_show?CGAffineTransformMakeTranslation(0, self.cover.h):CGAffineTransformIdentity;

    }];
    
}
-(UIView *)cover{
    if(!_cover){

        UIView *cover=[[UIView alloc] initWithFrame:(CGRect){0,-self.view.h*.6,self.view.w,self.view.h*.6}];
        cover.backgroundColor=[UIColor cyanColor];
        self.cover=cover;
        [self.view addSubview:cover];
    }
    
    return _cover;
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor orangeColor]];
    UIButton *btn=[[YFButton1 alloc] init];
    [btn setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    self.btn=btn;
    [btn sizeToFit];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=btn;

}



@end



@implementation YFButton1

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x=self.titleLabel.w;
    self.titleLabel.x=0;
}

@end