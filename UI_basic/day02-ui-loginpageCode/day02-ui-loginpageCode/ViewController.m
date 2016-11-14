//
//  ViewController.m
//  day02-ui-loginpageCode
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#define BubbleSize {120,120}
#define USERNAME @"abc"
#define PWD @"111"
@interface ViewController ()
@property(nonatomic,weak)UIImageView *bubble1;
@property(nonatomic,weak)UIImageView *bubble2;
@property(nonatomic,weak)UIImageView *bubble3;
@property(nonatomic,weak)UIImageView *bubble4;
@property(nonatomic,weak)UITextField *username;
@property(nonatomic,weak)UITextField *password;
@property(nonatomic,weak)UIButton *submit;
@property(nonatomic,assign) BOOL lockScreen;
@property(nonatomic,weak)UIActivityIndicatorView *roller;
@property(nonatomic,weak)UILabel *emptyNote;
@property(nonatomic,weak)UIButton *warn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self doInit];
    [self bindistener];
    
    
}

-(void)addViews{
    CGRect main=self.view.frame;
    CGFloat midX=CGRectGetMidX(main);
    CGFloat midY=CGRectGetMidY(main);
    
    [self.view addSubview:[self createImageViewWithImg:@"background_image"
                 andFrame:main ]];
    
    NSArray *aniAry= [self createAniAryWithPref:@"Bubble_" from:1 to:5];
    self.bubble1=[self createBubbleWithFrame:(CGRect){midX,midY-midY/1.5,BubbleSize} andAniAry:aniAry on:self.view];
    self.bubble2=[self createBubbleWithFrame:(CGRect){midX-midX/2,midY-midY/2,BubbleSize} andAniAry:aniAry on:self.view];
    self.bubble3=[self createBubbleWithFrame:(CGRect){midX-midX/1.5,midY,BubbleSize} andAniAry:aniAry on:self.view];
    self.bubble4=[self createBubbleWithFrame:(CGRect){midX+midX/2,midY+midY/2,BubbleSize} andAniAry:aniAry on:self.view];
    
    UIImageView *usernameLv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_userName"]];
    [usernameLv setHighlightedImage:[UIImage imageNamed:@"icon_username_normal" ]];
    self.username=[self createTFWithFrame:(CGRect){.25*midX,80,1.5*midX,30} leftView:usernameLv placeH:@"  Username" on:self.view];
    
    UIImageView *pwdLv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"]];
    [pwdLv setHighlightedImage:[UIImage imageNamed:@"icon_password_normal" ]];
    self.password=[self createTFWithFrame:(CGRect){.25*midX,CGRectGetMaxY(self.username.frame)+30,1.5*midX,30} leftView:pwdLv placeH:@"  Password" on:self.view];
    
    CGRect submitRect=(CGRect){.4*midX,CGRectGetMaxY(self.password.frame)+40 ,1.2*midX,60};
    self.submit=[self createButtonWithFrame:submitRect BGImg:[UIImage imageNamed:@"login_button"] title:@"Submit" color:[UIColor greenColor] on:self.view];
    
    
    
    
    UILabel *lab=[[UILabel alloc] initWithFrame:(CGRect){submitRect.origin.x,CGRectGetMaxY(submitRect)+30,submitRect.size
    }];
    [self uniformLabel:lab font:[UIFont systemFontOfSize:22 weight:3]] ;
    [lab setTextColor:[UIColor redColor]];
    self.emptyNote=lab;
    [self.view addSubview:lab];
    
    UIActivityIndicatorView *rol=[[UIActivityIndicatorView alloc] initWithFrame:
    (CGRect){submitRect.origin.x+20,CGRectGetMidY(submitRect)-15,30,30}];
    [rol setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [rol setColor:[UIColor blueColor ]];
    rol.hidesWhenStopped=YES;
    self.roller=rol;
    [self.view addSubview:rol];
    
    
    
    self.warn=[self createButtonWithFrame:(CGRect){-submitRect.size.width,CGRectGetMaxY(self.password.frame)+30,submitRect.size} BGImg:[UIImage imageNamed:@"warning_button"] title:@"用户名或密码错误" color:[UIColor whiteColor] on:self.view];
    [self.warn setEnabled:NO];
    [self.warn setAdjustsImageWhenDisabled:NO];
    
    
 
    
}

-(UIButton *) createButtonWithFrame:(CGRect)frame BGImg:(UIImage *)bgimg title:(NSString *)title color:(UIColor *)color on:(UIView *)view{
    UIButton *b = [[UIButton alloc] initWithFrame:frame];
    [b setTitle:title forState:UIControlStateNormal];
    [b setBackgroundImage:bgimg forState:UIControlStateNormal];
    [b setTitleColor:color forState:UIControlStateNormal];
    [b setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self uniformLabel:b.titleLabel font:[UIFont systemFontOfSize:22 weight:8]];
    [view addSubview:b];
    return b;
    
}
-(void)uniformLabel:(UILabel *)lab font:(UIFont *)font{
    [lab setShadowColor:[UIColor grayColor]];
    [lab setShadowOffset:(CGSize){1.5,1.5}];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setFont:font];
}
-(void)doInit{
    _lockScreen=NO;
    [self updateScreen];
}
-(void)bindistener{
    [self.submit addTarget:self  action:@selector(onsubmit) forControlEvents:UIControlEventTouchUpInside];
}


-(void)onsubmit{
    NSString *username = _username.text;
    NSString *password=_password.text;
    self.emptyNote.text=@"";
    [UIView animateWithDuration:.2 animations:^{
        self.warn.transform=CGAffineTransformIdentity;
        self.submit.transform=CGAffineTransformIdentity;
        self.roller.transform=CGAffineTransformIdentity;
    }];
   
    if(username.length==0){
        [_username becomeFirstResponder];
        [self.emptyNote setText:@"请输入用户名"];
        return ;
    }
    if(password.length==0){
        [_password becomeFirstResponder];
        [self.emptyNote setText:@"请输入密码"];
        return;
    }
    _lockScreen=YES;
    [self updateScreen];
    [self performSelector:@selector(login:) withObject:[NSString stringWithFormat:@"username=%@&password=%@",username,password] afterDelay:3];
}
-(void)login:(NSString *)info{
    NSArray *ary = [info componentsSeparatedByString:@"&"];
    NSString *username = [ary[0] componentsSeparatedByString:@"="][1];
    NSString *password = [ary[1] componentsSeparatedByString:@"="][1];
    BOOL b = [[username lowercaseString] isEqualToString:USERNAME]&&
    [[password lowercaseString] isEqualToString:PWD];
   
    [self performSelectorOnMainThread:@selector(loginResult:) withObject:[NSNumber numberWithBool:b] waitUntilDone:NO];
  
}
-(void)loginResult:(NSNumber *)result{
    if(![result boolValue]){
        [UIView animateWithDuration:.4 animations:^{
            
                _warn.transform=CGAffineTransformTranslate(_warn.transform, CGRectGetMidX(self.view.frame)-CGRectGetMidX(_warn.frame)+20, 0);
                _submit.transform=CGAffineTransformTranslate(_submit.transform, 0, 20+CGRectGetMaxY(_warn.frame)-CGRectGetMinY(_submit.frame)+15);
                _roller.transform=CGAffineTransformTranslate(_roller.transform, 0, _submit.transform.ty);
            [self performSelector:@selector(animateDelay) withObject:nil afterDelay:.4];
        }];
        
    }
    _lockScreen=NO;
    [self updateScreen];
}
-(void)animateDelay{
    [UIView animateWithDuration:.07 animations:^{
        _warn.transform=CGAffineTransformTranslate(_warn.transform, -30, 0);
        _submit.transform=CGAffineTransformTranslate(_submit.transform, 0, -23);
         _roller.transform=CGAffineTransformTranslate(_roller.transform, 0, -23);
        [self performSelector:@selector(animteDelay2) withObject:nil afterDelay:.05];
        
    }];
}
-(void)animteDelay2{
    [UIView animateWithDuration:.03 animations:^{
        _warn.transform=CGAffineTransformTranslate(_warn.transform, +10, 0);
        _submit.transform=CGAffineTransformTranslate(_submit.transform, 0, +8);
        _roller.transform=CGAffineTransformTranslate(_roller.transform, 0, +8);
        
    }];

}

-(void)startBubbleAni{
    [self startAni:_bubble1 withRepeat:2 andInterval:0.1];
    [self startAni:_bubble2 withRepeat:2 andInterval:0.1];
    [self startAni:_bubble3 withRepeat:2 andInterval:0.1];
    [self startAni:_bubble4 withRepeat:2 andInterval:0.1];
}
-(NSArray *)createAniAryWithPref:(NSString *)pref from:(int)from to:(int)to{
    NSMutableArray *mary = [NSMutableArray array];
    for(int i=from;i<=to;i++)
        [ mary addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%02d",pref,i]]];
    return [NSArray arrayWithArray:mary];
}
-(void)startAni:(UIImageView *)view withRepeat:(int)count andInterval:(CGFloat)inter{
    if([view isAnimating]) return;
    view.animationDuration=inter*view.animationImages.count;
    view.animationRepeatCount=count;
    [view startAnimating];
}

-(UIImageView *)createBubbleWithFrame:(CGRect)frame andAniAry:(NSArray *)ary on:(UIView *)view{
    UIImageView *iv=[self createImageViewWithImg:@"Bubble_01" andFrame:frame];
    iv.animationImages=ary;
    [view addSubview:iv];
    return iv;
}

-(UIImageView *)createImageViewWithImg:(NSString *)img andFrame:(CGRect)frame{
    UIImageView *iv=[[UIImageView alloc] initWithFrame:frame];
    iv.image=[UIImage imageNamed:img];
    return iv;
}
-(UITextField *)createTFWithFrame:(CGRect)frame leftView:(UIImageView *)lv placeH:(NSString *)ph on:(UIView *)view{
    UITextField * tf=[[UITextField alloc] initWithFrame:frame];
    [tf setBorderStyle:UITextBorderStyleNone];
    [tf setPlaceholder:ph];
    [tf setBackground:[UIImage imageNamed:@"textField_border"]];
    [tf setLeftView:lv];
    [tf setLeftViewMode:UITextFieldViewModeAlways];
    [tf setDisabledBackground:[UIImage imageNamed:@"textField_normal"]];
    
    [tf setFont:[UIFont systemFontOfSize:17 weight:5]];
    [view addSubview:tf];
    return tf;
}
-(void)updateScreen{
    self.username.enabled=!_lockScreen;
    self.password.enabled=!_lockScreen;
    ((UIImageView *)self.username.leftView).highlighted=_lockScreen;
    ((UIImageView *)self.password.leftView).highlighted=_lockScreen;
    _lockScreen?[self.roller startAnimating]:([self startBubbleAni],[self.roller stopAnimating]);
    self.submit.enabled=!_lockScreen;
  
    
    
}


@end
