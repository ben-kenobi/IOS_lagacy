//
//  YFQueryVC.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFQueryVC.h"
#import "YFPageGen.h"
#import "YFQueryTV.h"
@interface YFQueryVC ()
@property (nonatomic,weak)YFQueryTV *tv;
@property (nonatomic,weak)UIButton *btn1;
@property (nonatomic,weak)UIButton *btn2;
@property (nonatomic,weak)UITextField *tf;
@property (nonatomic,copy)NSString *url;
@end

@implementation YFQueryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.btn1){
        self.url=@"http://127.0.0.1/resources/querylist.json";
        [self loadQueryData];
    }else if(sender==self.btn2){
        self.url=@"http://127.0.0.1/resources/querylist.json";
        [self loadQueryData];
    }
}
-(void)initUI{
    UIButton *(^newBtn)(UIView *,NSString *)=^(UIView *sup,NSString *title){
        UIButton *btn1=[[UIButton alloc] init];
        [btn1.layer setMasksToBounds:YES];
        btn1.layer.cornerRadius=8;
        btn1.backgroundColor=[UIColor colorWithRed:.2 green:.5 blue:.8 alpha:1];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [sup addSubview:btn1];
        [btn1 setTitle:title forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return btn1;
    };
    self.btn1=newBtn(self.view,@"交货单");
    self.btn2=newBtn(self.view,@"签收单");
    CGFloat gap=12;
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(gap));
        make.height.equalTo(@33);
        make.width.equalTo(self.view).multipliedBy(.5).offset(-gap*2);
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(gap));
        make.right.equalTo(@(-gap));
        make.height.width.equalTo(self.btn1);
    }];
    UIView *tfbg=[[UIView alloc] init];
    [self.view addSubview:tfbg];
    tfbg.backgroundColor=[UIColor lightGrayColor];
    [tfbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_bottom).offset(gap);
        make.left.right.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    UITextField *tf=[[UITextField alloc] init];
    [tf setBackgroundColor:[UIColor whiteColor]];
    tf.layer.cornerRadius=10;
    tf.layer.masksToBounds=YES;
    tf.layer.borderColor=[[UIColor grayColor]CGColor] ;
    tf.layer.borderWidth=1;
    tf.leftView=[[UIView alloc] initWithFrame:(CGRect){0,0,12,0}];
    tf.leftViewMode=3;
    [tfbg addSubview:tf];
    self.tf=tf;
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@5);
        make.bottom.right.equalTo(@-5);
    }];
    
    
    YFQueryTV *tv=[[YFQueryTV alloc] init];
    self.tv=tv;
    [self.view addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.top.equalTo(tfbg.mas_bottom);
    }];

    [tv setSeparatorStyle:0];
    [tv setRowHeight:65];
    [self onBtnClicked:self.btn1];
    
}

-(void)loadQueryData{
    
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(self.url) cachePolicy:1 timeoutInterval:5];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            NSMutableArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            [self.tv setDatas:ary];
        }
        
    }] resume];
  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIViewController popVC];
}

@end
