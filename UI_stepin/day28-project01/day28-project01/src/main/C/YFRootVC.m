//
//  YFRootVC.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFRootVC.h"
#import "YFScanVC.h"
#import "YFQueryVC.h"

@interface YFRootVC ()
@property (nonatomic,weak)UIButton *scan;
@property (nonatomic,weak)UIButton *query;
@property (nonatomic,weak)UIImageView *iv;
@end

@implementation YFRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"船油签收";
    [self initUI];
}

-(void)initUI{
    UIImageView *iv=[[UIImageView alloc] initWithImage:img(@"discovery_groupBuy_icon")];
    [self.view addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@50);
        make.centerX.equalTo(@0);
    }];
    
    UIButton * (^newBtn)(UIView *,NSString *)=^(UIView *sup,NSString *title){
        UIButton *btn=[[UIButton alloc] init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setBackgroundImage:[img(@"RedButton") resizableStretchImg] forState:UIControlStateNormal];
        [btn setBackgroundImage:[img(@"RedButtonPressed") resizableStretchImg] forState:UIControlStateHighlighted];
        [sup addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return btn;
    };
    
    self.scan=newBtn(self.view,@"扫描二维码");
    self.query=newBtn(self.view,@"查   询");
    [self.scan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@44);
        make.width.equalTo(self.view).offset(-80);
        make.top.equalTo(iv.mas_bottom).offset(50);
    }];
    
    [self.query mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@44);
        make.width.equalTo(self.view).offset(-80);
        make.top.equalTo(self.scan.mas_bottom).offset(25);
    }];
    
}
-(void)onBtnClicked:(id)sender{
    if(sender==self.scan){
        YFScanVC *vc=[[YFScanVC alloc] init];
        [vc setUrl:@"http://127.0.0.1/resources/querylist.json"];
        [UIViewController pushVC:vc];
    }else if(sender==self.query){
        YFQueryVC *vc=[[YFQueryVC alloc] init];
        [vc setTitle:@"查   询"];
        [UIViewController pushVC:vc];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}
@end
