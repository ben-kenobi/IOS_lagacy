//
//  ViewController.m
//  day08-ui-wechat
//
//  Created by apple on 15/9/23.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFChatTvAdap.h"
#import "YFWechatMod.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,weak)UIButton *btn1;
@property (nonatomic,weak)UIButton *btn2;
@property (nonatomic,weak)UIButton *btn3;
@property (nonatomic,weak)UITextField *tf;
@property (nonatomic,weak)UIView *botv;

@property (nonatomic,strong)YFChatTvAdap *adap;
@property (nonatomic,strong)NSDictionary *replyDict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initListeners];
}




-(void)initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)onKeyboardChange:(NSNotification *)noti{
    CGFloat dura=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endframe=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:dura animations:^{
        self.botv.transform=CGAffineTransformMakeTranslation(0, endframe.origin.y-self.view.frame.size.height);
    }];
}

-(void)initUI{
    CGRect frame=self.view.frame;
    CGSize size=frame.size;
    CGFloat botH=44;
    size.height-=botH;
    
    UITableView *tv=[[UITableView alloc] initWithFrame:(CGRect){0,0,size} style:UITableViewStylePlain];
    [tv setAllowsSelection:NO];
    [tv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tv];
    self.tv=tv;
    [self.tv setBackgroundColor:[UIColor colorWithRed:1.000 green:0.945 blue:0.731 alpha:1.000]];
    
    self.adap=[YFChatTvAdap adapWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"]] tv:self.tv];
        
    
    UIView *botv=[[UIView alloc] initWithFrame:(CGRect){0,size.height,size.width,botH}];
    self.botv=botv;
    [self.view addSubview:botv];
    UIImageView *botbg=[[UIImageView alloc ] initWithFrame:botv.bounds];
    [self.botv addSubview:botbg];
    botbg.image=[UIImage imageNamed:@"LaunchImage"];
    
    CGFloat padV=8,padH=15,
    btnH=botH-padV*2;
    UIButton *(^createBtn)(CGRect,UIImage *,UIImage *,UIView *)=^(CGRect frame,UIImage *img,UIImage *hlimg,UIView *supV){
        UIButton *btn=[[UIButton alloc] initWithFrame:frame];
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:hlimg forState:UIControlStateHighlighted];
        [supV addSubview:btn];
        return btn;
    };
    
    self.btn1=createBtn((CGRect){padH,padV,btnH,btnH},[UIImage imageNamed:@"chat_bottom_voice_nor"],[UIImage imageNamed:@"chat_bottom_voice_press"],self.botv);
    self.btn3=createBtn((CGRect){size.width-padH-btnH,padV,btnH,btnH},[UIImage imageNamed:@"chat_bottom_up_nor"],
                        [UIImage imageNamed:@"chat_bottom_up_press"],self.botv);
    self.btn2=createBtn((CGRect){CGRectGetMinX(self.btn3.frame)-padH-btnH,padV,btnH,btnH},[UIImage imageNamed:@"chat_bottom_smile_nor"],[UIImage imageNamed:@"chat_bottom_smile_press"],botv);
    CGFloat x1=CGRectGetMaxX(self.btn1.frame)+padH;
    UITextField *tf=[[UITextField alloc] initWithFrame:(CGRect){x1,padV,CGRectGetMinX(self.btn2.frame)-x1-padH,btnH}];
    [tf setBackground:[UIImage imageNamed:@"chat_bottom_textfield"]];
    self.tf=tf;
    [tf setEnablesReturnKeyAutomatically:YES];
    [tf setReturnKeyType:UIReturnKeySend];
    [tf setDelegate:self];
    [botv addSubview:tf];
    
    
}


-(NSDictionary *)replyDict{
    if(nil==_replyDict){
        _replyDict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"reply" ofType:@"plist"]];
    }return _replyDict;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text=textField.text;
    [self sendMes:text type:ChatType_ME];
    
    dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
        
        NSString *rep=nil;
        for(int i=0;i<text.length&&!rep;i++){
            NSString *sub=[text substringWithRange:(NSRange){i,1}];
            rep=self.replyDict[sub];
        }
        if(!rep)
            rep=@"not found";
        [self sendMes:rep type:ChatTYpe_O];
    });
    textField.text=@"";
    return YES;
}
-(void)sendMes:(NSString *)mes type:(ChatType)type{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"HH:mm";
    NSString *time=[formatter stringFromDate:[NSDate date]];
    [self.adap addDatas:@[@{@"text":mes,@"type":[NSString stringWithFormat:@"%d",type],@"time":time}]];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
