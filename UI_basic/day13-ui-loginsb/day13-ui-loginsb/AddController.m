//
//  AddController.m
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "AddController.h"
#import "YFContact.h"

@interface AddController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *num;
@property (weak, nonatomic) IBOutlet UIButton *add;


@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}




-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.add){
        YFContact *con=[YFContact conWithDict:@{@"name":_name.text,@"num":_num.text}];
        if([self.delegate respondsToSelector:@selector(addContact:)]){
            [self.delegate addContact:con];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [self.name becomeFirstResponder];
}

-(void)onTfChange:(NSNotification *)noti{
    _add.enabled=self.name.text.length && self.num.text.length;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.name];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTfChange:) name:UITextFieldTextDidChangeNotification object:self.num];
    [_add addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initState{
    [self onTfChange:nil];
}

-(void)initUI{
    
}


@end
