
//
//  DrawPad.m
//  day15-ui-quartz2d
//
//  Created by apple on 15/10/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "DrawPad.h"
#import "YFProgress1.h"
#import "Masonry.h"
#import "YFProgress2.h"
#import "UIColor+Extension.h"

@interface DrawPad ()
@property (nonatomic,weak)UISlider *slider;
@property (nonatomic,weak)YFProgress1 *pr;
@property (nonatomic,weak)YFProgress2 *pr2;
@property (nonatomic,assign)NSInteger style;

@end

@implementation DrawPad



-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"subview222222222--------->");
    return [super hitTest:point withEvent:event];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"222222222--------->000000000");
}


-(void)onChange:(id)sender{
    if(sender==_slider) {
        if (_style==0) {
            _pr.perc=_slider.value;
        }else if(_style==1){
            _pr2.perc=_slider.value;
        }
    }
}

-(void)initUI{
    UISlider *slider=[[UISlider alloc] init];
    self.slider=slider;
    [self addSubview:slider];
    [slider addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-20);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    if(_style==0){
        YFProgress1 *pr=[[YFProgress1 alloc] init];
        self.pr=pr;
        [self addSubview:pr];
        [pr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.bottom.equalTo(@-60);
        }];
        [pr setBackgroundColor:[UIColor cyanColor]];
    }else if(_style==1){
        YFProgress2 *pr2=[[YFProgress2 alloc] init];
        self.pr2=pr2;
        [self addSubview:pr2];
        [pr2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.bottom.equalTo(@-60);
        }];
        [pr2 setBackgroundColor:[UIColor randomColor]];
    }
}


-(instancetype)initWithStyle:(NSInteger)style{
    if(self=[super init]){
        self.style=style;
        [self initUI];
    }
    return self;
        
}



@end
