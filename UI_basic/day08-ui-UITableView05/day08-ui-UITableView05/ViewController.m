//
//  ViewController.m
//  day08-ui-UITableView05
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFTVadap.h"
#import "YFChatMod.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic)  UITableView *tv;
@property (weak, nonatomic)  UIButton *btn1;
@property (weak, nonatomic)  UITextField *tf;
@property (weak, nonatomic)  UIButton *btn2;
@property (weak, nonatomic)  UIButton *btn3;
@property (strong,nonatomic) YFTVadap *adap;
@property (weak, nonatomic) UIView *botv;

@property (strong,nonatomic) NSDictionary *replyDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initListeners];
}


-(void)initListeners{
    SEL sel=@selector(onBtnClicked:);
    [self.btn1 addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)onKeyboardShow:(NSNotification *)noti{
    
    CGRect rec=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat dura=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:dura animations:^{
        self.view.transform=CGAffineTransformMakeTranslation(0, rec.origin.y-[UIScreen mainScreen].bounds.size.height);
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *text=textField.text;
    [self sendMes:text type:ChatType_ME];
    
    
    
    
    dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
       
        NSString *str=nil;
        
        for(NSInteger i=0;i<text.length&&!str;i++){
            NSString *sub=[text substringWithRange:(NSRange){i,1}];
            str=[self.replyDict objectForKey:sub];
        }
        if(!str)
            str=@"no found";
        
        [self sendMes:str type:ChatType_O];
    });
    textField.text=@"";
    return YES;
}

-(void)sendMes:(NSString *)mes type:(ChatType)type{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"HH:mm";
    NSDate *date=[NSDate date];
    NSString *time=[formatter stringFromDate:date];
    
    NSDictionary *dic=@{@"text":mes,@"time":time,@"type":[NSNumber numberWithInteger:type]};
    [self.adap addDatas:@[dic]];
}


-(void)onBtnClicked:(UIButton*)sender{
    if(sender==_btn1){
        
    }else if(sender==_btn2){
        
    }else if(sender==_btn3){
        
    }
}






-(NSDictionary *)replyDict{
    if(nil==_replyDict){
        _replyDict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"reply" ofType:@"plist"]];
    }
    return _replyDict;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)initUI{
    CGRect frame=self.view.frame;
    CGSize size=frame.size;
    CGFloat both=44;
    size.height-=both;
    UITableView *tv=[[UITableView alloc] initWithFrame:(CGRect){0,0,size} style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv=tv;
    
    UIView *botv=[[UIView alloc] initWithFrame:(CGRect){0,size.height,size.width,both}];
    [self.view addSubview:botv];
    UIImageView *iv=[[UIImageView alloc] initWithFrame:botv.bounds];
    iv.image=[UIImage imageNamed:@"chat_bottom_bg"];
    [botv addSubview:iv];
    self.botv=botv;
    
    UIButton *(^createBtn)(CGRect,UIImage *,UIImage *,UIView *)=^(CGRect frame,UIImage *ima,UIImage *hlimg,UIView *supV){
        UIButton *btn=[[UIButton alloc] initWithFrame:frame];
        [btn setImage:ima forState:UIControlStateNormal];
        [btn setImage:hlimg forState:UIControlStateHighlighted];
        [supV addSubview:btn];
        return btn;
    };
    
    CGFloat pad=8;
    CGFloat btnw=both-pad*2;
    
    self.btn1=createBtn((CGRect){pad*2,pad,btnw,btnw},[UIImage imageNamed:@"chat_bottom_voice_nor"],[UIImage imageNamed:@"chat_bottom_voice_press"],botv);
    self.btn3=createBtn((CGRect){size.width-pad*2-btnw,pad,btnw,btnw},[UIImage imageNamed:@"chat_bottom_up_nor"],[UIImage imageNamed:@"chat_bottom_up_press"],botv);
    self.btn2=createBtn((CGRect){CGRectGetMinX(self.btn3.frame)-pad*2-btnw,pad,btnw,btnw},[UIImage imageNamed:@"chat_bottom_smile_nor"],[UIImage imageNamed:@"chat_bottom_smile_press"],botv);
    
    CGFloat tfx=CGRectGetMaxX(self.btn1.frame)+pad*2;
    UITextField *tf=[[UITextField alloc] initWithFrame:(CGRect){tfx,pad,CGRectGetMinX(self.btn2.frame)-pad*2-tfx,btnw}];
    [tf setBackground:[UIImage imageNamed:@"chat_bottom_textfield"]];
    [tf setEnablesReturnKeyAutomatically:YES];
    [tf setReturnKeyType:UIReturnKeySend];
    [tf setDelegate:self];
    [botv addSubview:tf];
    self.tf=tf;
    
    
    [self.tv setBackgroundColor:[UIColor colorWithRed:.8 green:.8 blue:.7 alpha:1]];
    self.adap=[YFTVadap adapWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"]] tv:self.tv];
    [self.tv setAllowsSelection:NO];
    [self.tv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tv.delegate=_adap;
    self.tv.dataSource=_adap;
   
}

@end
