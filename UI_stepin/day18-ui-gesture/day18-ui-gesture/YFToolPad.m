//
//  YFToolPad.m
//  day18-ui-gesture
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFToolPad.h"
#import "Masonry.h"

#define  MAXW 30.1


@interface YFToolPad ()

{
    NSMutableArray *sliders;
}

@property (nonatomic,weak)UIButton *colorBtn;
@property (nonatomic,weak)UITextField *tf;


@end

@implementation YFToolPad



-(void)initUI{
    sliders=[NSMutableArray array];
    CGFloat pad=5;
    UIView * (^newV)(UIView *)=^(UIView *sup){
        UIView *view=[[UIView alloc] init];
        UIButton *btn=[[UIButton alloc] init];
        [view addSubview:btn];
        UISlider *slider=[[UISlider alloc] init];
        [view addSubview:slider];
        UITextField *tf=[[UITextField alloc] init];
        [view addSubview:tf];
        tf.layer.cornerRadius=5;
        tf.layer.borderColor=[[UIColor blueColor]CGColor];
        tf.layer.borderWidth=2;
        tf.leftView=[[UIView alloc] initWithFrame:(CGRect){0,0,7,0}];
        tf.leftViewMode=3;
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@(pad));
            make.right.equalTo(@(-pad));
            make.bottom.equalTo(@0);
            make.height.equalTo(@25);
        }];
        [sliders addObject:slider];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(slider);
            make.top.equalTo(@(pad));
            make.bottom.equalTo(slider.mas_top);
            make.width.equalTo(view).multipliedBy(.4);
        }];
        
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(btn.mas_right).offset(pad);
            make.right.equalTo(slider);
            make.top.bottom.equalTo(btn);
        }];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onColorChange:) name:UITextFieldTextDidChangeNotification object:tf];
        [slider addTarget:self action:@selector(onColorChange:) forControlEvents:UIControlEventValueChanged];
        [btn addTarget:self action:@selector(onColorChange:) forControlEvents:UIControlEventTouchUpInside];
        [sup addSubview:view];
        return view;
    };
    
    UIView *views[3];
    for(int i=0;i<3;i++){
        views[i]=newV(self);
        views[i].tag=i;
        UIView *prev;
        if(i)
            prev=views[i-1];
        [views[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-pad));
            make.height.equalTo(@60);
            make.width.equalTo(self).multipliedBy(.333).offset(-pad*1.333);
            if(!i)
                make.leading.equalTo(@(pad));
            else
                make.leading.equalTo(prev.mas_right).offset(pad);
        }];
    }
    
    UIButton *btn=[[UIButton alloc] init];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(onColorChange:) forControlEvents:UIControlEventTouchUpInside];
    UIView *v=views[0];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(pad));
        make.bottom.equalTo(v.mas_top).offset(-pad);
        make.width.equalTo(@60);
    }];
    self.colorBtn=btn;
    [self.colorBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    
    UITextField *tf=[[UITextField alloc] init];
    [self addSubview:tf];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onWidChange:) name:UITextFieldTextDidChangeNotification object:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-pad));
        make.bottom.top.equalTo(btn);
        make.width.equalTo(@50);
    }];
    tf.layer.cornerRadius=3;
    tf.layer.borderColor=[[UIColor cyanColor]CGColor];
    tf.layer.borderWidth=2;
    tf.leftView=[[UIView alloc] initWithFrame:(CGRect){0,0,7,0}];
    self.tf=tf;
    tf.leftViewMode=3;
    
    UISlider *slider=[[UISlider alloc] init];
    self.slider=slider;
    [self addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_right).offset(pad);
        make.bottom.equalTo(btn);
        make.top.equalTo(btn);
        make.right.equalTo(tf.mas_leading).offset(-pad);
    }];
    [slider addTarget:self action:@selector(onWidChange:) forControlEvents:UIControlEventValueChanged];
    
    
    [self onColorChange:btn];
    
}

-(void)updateColorBtn:(UIButton *)btn idx:(NSInteger)idx co:(CGFloat)co{
    CGColorRef color1=[self.colorBtn.layer backgroundColor];
    CGFloat rgb1[4]={0,0,0,1},rgb2[4]={0,0,0,1};
    CGFloat *rgb=(CGFloat *)CGColorGetComponents(color1);
    NSInteger si=CGColorGetNumberOfComponents(color1);
    for(int i=0;i<si;i++){
        rgb1[i]=rgb[i];
    }
    rgb1[idx]=co;
    rgb2[idx]=co;
    CGColorRef color2=CGColorCreate(CGColorGetColorSpace(color1), rgb2);
    color1=CGColorCreate(CGColorGetColorSpace(color1), rgb1);
    [self.colorBtn.layer setBackgroundColor:color1];
    [btn.layer setBackgroundColor:color2];
    CGColorRelease(color1);
    CGColorRelease(color2);
    
}

-(void)onWidChange:(id)sender{
    if(sender==self.slider){
        CGFloat wid=self.slider.value*(MAXW-.1)+.1;
        [self.tf setText:[NSString stringWithFormat:@"%.1f",wid]];
    }else if([sender isKindOfClass:[NSNotification class]]){
        UITextField *tf=[sender object];
            if(tf==self.tf){
                CGFloat wid=tf.text.doubleValue;
                if(wid>MAXW){
                    wid=MAXW;
                    NSString *str=[NSString stringWithFormat:@"%.1f",wid];
                    tf.text=str;
                }
            
            
            self.slider.value=(wid-.1)/(MAXW-.1);
        }
    }
}

-(void)onColorChange:(id)sender{
    if([sender isKindOfClass:[NSNotification class]]){
        UITextField *tf=[sender object];
        int val=tf.text.intValue>255?255:tf.text.intValue;
        tf.text =[NSString stringWithFormat:@"%d",val];
        UISlider *slider=[[tf superview] subviews][1];
        CGFloat co=val/255.0;
        [slider setValue:co];
        UIButton *btn=[[tf superview] subviews][0];
        NSInteger idx=[tf superview].tag;
        [self updateColorBtn:btn idx:idx co:co];
    }else if([sender isKindOfClass:[UISlider class]]){
        UISlider *slider=sender;
        CGFloat co=slider.value;
        int val=(int)(co*255);
        UITextField *tf=[slider.superview subviews][2];
        [tf setText:[NSString stringWithFormat:@"%d",val]];
        UIButton *btn=[[tf superview] subviews][0];
        NSInteger idx=[tf superview].tag;
        [self updateColorBtn:btn idx:idx co:co];
    }else if([sender isKindOfClass:[UIButton class]]){
        self.curBtn=sender;
        if(self.colorChange){
            self.colorChange();
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)initState{
    self.slider.value=1;
    [self onWidChange:self.slider];
    for(UISlider *slid in sliders){
        slid.value=1;
        [self onColorChange:slid];
    }
}


-(instancetype)init{
    if(self=[super init]){
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews{
    [self initState];
}


@end
