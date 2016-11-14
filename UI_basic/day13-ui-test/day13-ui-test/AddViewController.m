//
//  AddViewController.m
//  day13-ui-test
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (assign,nonatomic)BOOL lock;
@property (weak,nonatomic)UIBarButtonItem *edit;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange:(NSNotification *)noti{
    self.add.enabled=_name.text.length&&_number.text.length?YES:NO;
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.add){
   
        self.info=@{@"name":self.name.text,@"num":self.number.text};
        if([self.delegate respondsToSelector:@selector(addOrUpdateInfo:idx:)]){
            [self.delegate addOrUpdateInfo:self.info idx:self.idx];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if(sender==self.edit){
        _lock=!_lock;
        [self updateUI];
    }
}


-(void)initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_name];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_number];
    [_add addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initUI{
    [_number setKeyboardType:UIKeyboardTypeNumberPad];
    if(self.idx){
        UIBarButtonItem *edit=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onBtnClicked:)];
        self.editing=edit;
        self.navigationItem.rightBarButtonItem=edit;
        self.edit=edit;
    }
}

-(void)updateUI{
    self.name.enabled=!_lock;
    self.number.enabled=!_lock;
    self.add.hidden=_lock;
    if(self.idx){
        [self.add setTitle:@"update" forState:UIControlStateNormal];
        self.name.text=self.info[@"name"];
        self.number.text=self.info[@"num"];
        if(!_lock)
        [self.name becomeFirstResponder];
    }else
        [self.add setTitle:@"add" forState:UIControlStateNormal];
    [self textChange:nil];
}
-(void)initState{
    _lock=self.idx;
    [self updateUI];
    
}
-(void)viewDidAppear:(BOOL)animated{
    if(!self.idx)
       [self.name becomeFirstResponder];
}

@end
