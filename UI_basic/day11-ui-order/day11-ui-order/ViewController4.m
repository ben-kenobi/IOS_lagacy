//
//  ViewController4.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController4.h"

#import "YFFlagAdapter.h"
#import "Masonry.h"
#import "YFCityAdap.h"
#import "YFFoodAdap.h"

@interface ViewController4 ()
@property (weak, nonatomic)  UITextField *tf;
@property (weak,nonatomic)UIPickerView *pv;
@property (weak,nonatomic)UIButton *btn;
@property (strong,nonatomic)YFFlagAdapter *adap;
@property (strong,nonatomic)YFCityAdap *ada;
@property (strong,nonatomic)YFFoodAdap *fada;

@property (weak,nonatomic)UIButton *random;

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI7];
    
}

-(void)initUI7{
    UIPickerView *pv=[[UIPickerView alloc] init];
    [self.view addSubview:pv];
    self.pv=pv;
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    
    UILabel *(^newLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setBackgroundColor:[UIColor orangeColor]];
        [lab setFont:[UIFont systemFontOfSize:13]];
        return lab;
    };
    UILabel *labs[3];
    CGFloat wid=(pv.frame.size.width-30*4)*.333;
    for(int i=0;i<3;i++){
        labs[i]=newLab(self.view);
        [labs[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pv.mas_bottom);
            make.height.equalTo(@30);
            make.width.equalTo(@(wid));
        }];
    }
    
    [labs[0] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
    }];
    [labs[1] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
    }];
    [labs[2] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-30);
    }];
    
    _fada=[YFFoodAdap adapWithPv:pv datas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"foods.plist" ofType:nil]] labs:@[labs[0],labs[1],labs[2]]];
    
    
    UIButton *random=[[UIButton alloc] init];
    [self.view addSubview:random];
    self.random=random;
    [random setTintColor:[UIColor redColor]];
    [random setBackgroundColor:[UIColor cyanColor]];
    [random setTitle:@"random" forState:UIControlStateNormal];
    [random setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [random mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
        make.centerY.equalTo(@0);
    }];
    
    [random addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initUI6{
    UITextField *tf=[[UITextField alloc] init];
    self.tf=tf;
    [self.view addSubview:tf];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.right.equalTo(@-20);
        
    }];
    
    UIDatePicker *dp=[[UIDatePicker alloc] init];
    [dp setDatePickerMode:UIDatePickerModeDate];
    [dp setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-hans"]];
    [dp addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
    tf.inputView=dp;
    [self onChange:dp];
    
    UIToolbar *tb=[[UIToolbar alloc] initWithFrame:(CGRect){0,0,0,30}];
    [tb setBarTintColor:[UIColor orangeColor]];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(endEdit:)];
    [tb setItems:@[item1,item2]];
    tf.inputAccessoryView=tb;
}
-(void)initUI5{
    UIPickerView *pv=[[UIPickerView alloc] init];
    [self.view addSubview:pv];
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    
    UILabel *province =[[UILabel alloc] init];
    UILabel *city=[[UILabel alloc] init];
    [self.view addSubview:province];
    [self.view addSubview:city];
    [province setTextAlignment:NSTextAlignmentCenter];
    [province setBackgroundColor:[UIColor orangeColor]];
    [city setTextAlignment:NSTextAlignmentCenter];
    [city setBackgroundColor:[UIColor orangeColor]];
    
    [province mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(pv.mas_bottom);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
    
    [city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.height.top.width.equalTo(province);
    }];
    
    _ada=[YFCityAdap adapWithPv:pv andDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cities" ofType:@"plist"]] province:province city:city];
    
}



-(void)initUI3{
    UIPickerView *pv=[[UIPickerView alloc] init];
    [self.view addSubview:pv];
    self.pv=pv;
    [pv setBackgroundColor:[UIColor clearColor]];
    [self.pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
    }];
    
    _adap=[YFFlagAdapter adapWithPv:pv andDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"flags" ofType:@"plist"]]];
    
}





-(void)initUI4{
    UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){30,30,50,30}];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    self.btn=btn;
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.btn){
        UIUserNotificationSettings *settig=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        UIApplication *app=[UIApplication sharedApplication];
        app.applicationIconBadgeNumber=4;
        [app registerUserNotificationSettings:settig];
        [app openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    }else if(sender==self.random){
        [self.fada randomSelect];
    }
   
}


-(void)initUI2{
    CGFloat wid=self.view.frame.size.width;
    UITextField *tf=[[UITextField alloc] initWithFrame:(CGRect){10,40,wid-20,40}];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:tf];
    self.tf=tf;
    UIDatePicker *dp=[[UIDatePicker alloc] init];
    [dp setDatePickerMode:UIDatePickerModeDate];
    [dp setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-hans"]];
    [tf setInputView:dp];
    
    [dp addTarget:self  action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
    [self onChange:dp];
    
    
    UIToolbar *tb=[[UIToolbar alloc]initWithFrame:(CGRect){0,0,0,30}];
    [tb setBarTintColor:[UIColor orangeColor]];
    [tf setInputAccessoryView:tb];
    
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(endEdit:)];
    [tb setItems:@[item1,item2]];
    
}

-(void)initUI{
    UIDatePicker *dp=[[UIDatePicker alloc] init];
    [dp setDatePickerMode:UIDatePickerModeDate];
    NSLocale *local=[NSLocale localeWithLocaleIdentifier:@"zh-hans"];
   [dp setLocale:local];

    [_tf setInputView:dp];
    
    UIToolbar *tb=[[UIToolbar alloc] initWithFrame:(CGRect){0,0,self.view.frame.size.width,50}];
    UIBarButtonItem *itm1=[[UIBarButtonItem alloc] initWithTitle:@"first" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *itm2=[[UIBarButtonItem alloc] initWithTitle:@"second" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *itm3=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *itm4=[[UIBarButtonItem alloc] initWithTitle:@"finish" style:UIBarButtonItemStylePlain target:self action:@selector(endEdit:)];
    
    [tb setItems:@[itm1,itm2,itm3,itm4]];
    [tb setBackgroundColor:[UIColor blueColor]];
    [tb setTintColor:[UIColor greenColor]];
    [tb setBarTintColor:[UIColor orangeColor]];
   
    
    [_tf setInputAccessoryView:tb];
    
    [dp addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventValueChanged];
}
-(void)onChange:(UIDatePicker *)dp{
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    df.dateFormat=@"yyyy年MM月dd日 HH:mm:ss";
    _tf.text=[df stringFromDate:dp.date];
   
}

-(void)endEdit:(UIButton *)sender{
    [_tf resignFirstResponder];
}

@end
