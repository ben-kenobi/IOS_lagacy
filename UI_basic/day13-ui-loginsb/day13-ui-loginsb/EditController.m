//
//  EditController.m
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "EditController.h"
#import "YFContact.h"

@interface EditController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
@property (weak, nonatomic) IBOutlet UIButton *commit;
@property (weak, nonatomic) IBOutlet UITextField *num;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (assign,nonatomic) BOOL lock;

@end

@implementation EditController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
}


-(void)initUI{
    
}
-(void)initState{
    _lock=YES;
    [self updateUI];
}
-(void)updateUI{
    self.commit.enabled=!_lock;
    self.num.enabled=!_lock;
    self.name.enabled=!_lock;
    self.edit.title=_lock?@"edit":@"cancel";
    self.name.text=_con.name;
    self.num.text=_con.num;
}
-(void)initListeners{
    self.edit.target=self ;
    SEL sel=@selector(onBtnClicked:);
    self.edit.action=sel;
    [self.commit addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
}


-(void)onBtnClicked:(id)sender{
    if(sender==self.edit){
        _lock=!_lock;
        [self updateUI];
    }else if(sender==self.commit){
        self.con.name=self.name.text;
        self.con.num=self.num.text;
        if([self.delegate respondsToSelector:@selector(commitEdit)]){
            [self.delegate commitEdit];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
