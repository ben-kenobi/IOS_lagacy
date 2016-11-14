

//
//  MsgVC.m
//  day53-msgNfaceNcloud
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "MsgVC.h"
#import "AVObject.h"
@interface MsgVC()
@property (nonatomic,strong)UITextField *name;
@property (nonatomic,strong)UITextField *content;
@property (nonatomic,strong)UITextField *type;

@end

@implementation MsgVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    
    
}


-(void)postMsg{
    if(self.name.text.length==0 || self.content.text.length==0){
        [[[UIAlertView alloc] initWithTitle:@"标题内容部能为空" message:@"请输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return ;
    }
    if([self.type.text isEqualToString:@"1"]||[self.type.text isEqualToString:@"2"]){
        AVObject *obj= [AVObject objectWithClassName:@"MsgTable"];
        [obj setObject:self.name.text forKey:@"title"];
        [obj setObject:self.content.text forKey:@"content"];
        [obj setObject:[NSNumber numberWithInteger:self.type.text.integerValue ]  forKey:@"type"];
        [obj setObject:[[NSDate date] timeFormat] forKey:@"createTime"];
        
        [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"%@",error);
                 [[[UIAlertView alloc] initWithTitle:@"保存数据失败" message:@"请重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        }];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"类型错误" message:@"请输入1或2" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}


-(void) initUI{
    self.title=@"compose";

    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITextField *(^newtf)(NSString *)=^(NSString *ph){
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = ph;
        [self.view addSubview:tf];
        tf.layer.cornerRadius=8;
        tf.layer.borderColor=[UIColor grayColor].CGColor;
        tf.layer.borderWidth=1;
        tf.leftView=[[UIView alloc] initWithFrame:(CGRect){0,0,10,0}];
        tf.leftViewMode=UITextFieldViewModeAlways;
        return tf;
    };
    
    self.name = newtf(@"name");
    self.content = newtf(@"content");
    self.type = newtf(@"type");
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@38);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.top.equalTo(@100);
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@38);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.top.equalTo(self.name.mas_bottom).offset(30);
    }];
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@38);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.top.equalTo(self.content.mas_bottom).offset(30);
    }];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"post" style:UIBarButtonItemStyleDone target:self action:@selector(postMsg)];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed=true;
    }
    return self;
}
@end
