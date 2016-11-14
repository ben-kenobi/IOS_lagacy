//
//  AddController.m
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AddController.h"
#import "Masonry.h"
#import "YFContact.h"

@interface AddController ()

@property (nonatomic,weak)UITextField *name;
@property (nonatomic,weak)UITextField *num;
@property (nonatomic,weak)UIButton *add;

@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}

-(void)initState{
    [self onTfChange:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self.name becomeFirstResponder];
}
-(void)onTfChange:(NSNotification *)noti{
    self.add.enabled=_num.text.length&&_name.text.length;
}
-(void)initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.name];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.num];
    [_add addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onBtnClicked:(UIButton *)sender{
    if(sender == _add){
        YFContact *contact=[YFContact contactWithDict:@{@"name":_name.text,@"num":_num.text}];
        if([self.delegate respondsToSelector:@selector(addContact:)]){
            [self.delegate addContact:contact];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=@"add";
    
    UITextField *name=[[UITextField alloc] init];
    UITextField *num=[[UITextField alloc] init];
    UIButton *add=[[UIButton alloc] init];
    self.name=name;self.num=num;self.add=add;
    [self.view addSubview:name];
    [self.view addSubview:num];
    [self.view addSubview:add];
    [name setPlaceholder:@"name"];
    [num setPlaceholder:@"number"];
    [name setBorderStyle:UITextBorderStyleRoundedRect];
    [num setBorderStyle:UITextBorderStyleRoundedRect];
    
    [add setBackgroundColor:[UIColor orangeColor]];
    [add setTitle:@"Add" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [add setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        
    }];
    
  
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(name);
        make.top.equalTo(name.mas_bottom).offset(20);
    }];
    
    
  
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
