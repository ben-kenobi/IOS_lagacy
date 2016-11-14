//
//  UpdateController.m
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UpdateController.h"
#import "Masonry.h"
#import "YFContact.h"

@interface UpdateController ()
@property (nonatomic,weak)UIBarButtonItem *edit;
@property (nonatomic,weak)UITextField *name;
@property (nonatomic,weak)UITextField *num;
@property (nonatomic,weak)UIButton *update;
@property (nonatomic,assign) BOOL lock;
@end

@implementation UpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
    
}

-(void)initState{
    _lock=YES;
    [self updateUI];
}
-(void)updateUI{
    self.name.enabled=!_lock;
    self.num.enabled=!_lock;
    self.update.hidden=_lock;
    self.edit.title=_lock?@"edit":@"cancel";
    self.name.text=self.cont.name;
    self.num.text=self.cont.num;
}

-(void)initListeners{
    [self.update addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.edit){
        _lock=!_lock;
        [self updateUI];
    }else if(sender==self.update){
        self.cont.name=self.name.text;
        self.cont.num=self.num.text;
        if([self.delegate respondsToSelector:@selector(updateList)]){
            [self.delegate updateList];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=@"update";

    
    UITextField *name=[[UITextField alloc] init];
    UITextField *num=[[UITextField alloc] init];
    UIButton *update=[[UIButton alloc] init];
    self.name=name;self.num=num;self.update=update;
    [self.view addSubview:name];
    [self.view addSubview:num];
    [self.view addSubview:update];
    [name setPlaceholder:@"name"];
    [num setPlaceholder:@"number"];
    [name setBorderStyle:UITextBorderStyleRoundedRect];
    [num setBorderStyle:UITextBorderStyleRoundedRect];
    
    [update setBackgroundColor:[UIColor orangeColor]];
    [update setTitle:@"update" forState:UIControlStateNormal];
    [update setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [update setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        
    }];
    
    
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(name);
        make.top.equalTo(name.mas_bottom).offset(20);
    }];
    
    
    
    [update mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    
    
    UIBarButtonItem *edit=[[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(onBtnClicked:)];
    [self.navigationItem setRightBarButtonItem:edit];
    self.edit=edit;
    
}











@end
