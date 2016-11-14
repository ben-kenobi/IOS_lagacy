//
//  ViewController.m
//  day08-ui-wechat02
//
//  Created by apple on 15/9/24.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFWechatAdap.h"
#import "YFWechatMod.h"

@interface ViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)UITableView *tv;
@property (nonatomic,weak)UITextField *tf;
@property (nonatomic,strong)YFWechatAdap *adap;
@property (nonatomic,strong)NSDictionary *replyDict;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initListeners];
}


-(void)initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKBchange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)onKBchange:(NSNotification *)noti{
    
    CGFloat dura=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rec=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:dura animations:^{
        self.view.transform=CGAffineTransformMakeTranslation(0, rec.origin.y-self.view.frame.size.height);
    }];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *text=textField.text;
    [self sendMes:text type:WechatTYpe_ME];
    textField.text=@"";
    
    dispatch_after(dispatch_time(0, 1e9), dispatch_get_main_queue(), ^{
        NSString *rep=nil;
        for(int i=0;i<text.length&&!rep;i++){
            rep=self.replyDict[[text substringWithRange:(NSRange){i,1}]];
        }
        if(!rep)
            rep=@"not found!";
        [self sendMes:rep type:WechatType_O];
    });
    
    return YES;
}


-(void)sendMes:(NSString *)mes type:(WechatType)type{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"HH:mm";
    NSString *time=[formatter stringFromDate:[NSDate date]];
    [self.adap appendDatas:@[@{@"time":time,@"text":mes,@"type":[NSNumber numberWithInteger:type]}]];
}


-(NSDictionary *)replyDict{
    if(nil==_replyDict){
        _replyDict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"reply" ofType:@"plist"]];
    }
    return _replyDict;
}

-(void)initUI{
    UIColor * bgcolor=[UIColor colorWithRed:0.873 green:1.000 blue:0.957 alpha:1.000];
    CGSize tvsize=self.view.frame.size;
    CGFloat botH=44;
    tvsize.height-=botH;
    
    [self.view.window setBackgroundColor:bgcolor];
    UITableView *tv =[[UITableView alloc] initWithFrame:(CGRect){0,0,tvsize} style:UITableViewStylePlain];
    self.tv=tv;
    [self.view addSubview:tv];
    self.adap=[YFWechatAdap adapWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"]] tv:tv];
    [tv setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tv setAllowsSelection:NO];
    [tv setBackgroundColor:bgcolor];
    
    UIView  *botv=[[UIView alloc] initWithFrame:(CGRect){0,tvsize.height,tvsize.width,botH}];
    [self.view addSubview:botv];
    
    UIImageView *iv=[[UIImageView alloc] initWithFrame:botv.bounds];
    iv.image=[UIImage imageNamed:@"LaunchImage"];
    [botv addSubview:iv];
    
    UIButton *(^createBtn)(CGRect,UIImage *,UIImage *,UIView *)=^(CGRect frame,UIImage *img,UIImage *hlimg,UIView *supV){
        UIButton *btn=[[UIButton alloc] initWithFrame:frame];
        [btn setImage:img forState:UIControlStateNormal];
        [btn setImage:hlimg forState:UIControlStateHighlighted];
        [supV addSubview:btn];
        return btn;
    };
    
    CGFloat padV=8,padH=15,btnH=botH-padV*2;
    [botv addSubview:createBtn((CGRect){padH,padV,btnH,btnH},[UIImage imageNamed:@"chat_bottom_voice_nor"],[UIImage imageNamed:@"chat_bottom_voice_press"],botv)];
    [botv addSubview:createBtn((CGRect){tvsize.width-padH-btnH,padV,btnH,btnH},[UIImage imageNamed:@"chat_bottom_voice_nor"],[UIImage imageNamed:@"chat_bottom_voice_press"],botv)];
    CGFloat rx=tvsize.width-padH*2-btnH*2;
    [botv addSubview:createBtn((CGRect){rx,padV,btnH,btnH},[UIImage imageNamed:@"chat_bottom_voice_nor"],[UIImage imageNamed:@"chat_bottom_voice_press"],botv)];
    CGFloat lx=padH*2+btnH;
    UITextField *tf=[[UITextField alloc] initWithFrame:(CGRect){lx,padV,rx-lx-padH,btnH}];
    [tf setBackground:[UIImage imageNamed:@"chat_bottom_textfield"]];
    self.tf=tf;
    [botv addSubview:tf];
    [tf setEnablesReturnKeyAutomatically:YES];
    [tf setReturnKeyType:UIReturnKeySend];
    tf.delegate=self;
    UIView *lv=[[UIView alloc] initWithFrame:(CGRect){0,0,8,8}];
    tf.leftView=lv;
    [tf setLeftViewMode:UITextFieldViewModeAlways];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
