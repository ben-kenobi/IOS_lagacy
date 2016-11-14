//
//  ViewController.m
//  day02-ui-loginpage
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bubble1;
@property (weak, nonatomic) IBOutlet UIImageView *bubble2;
@property (weak, nonatomic) IBOutlet UIImageView *bubble3;
@property (weak, nonatomic) IBOutlet UIImageView *bubble4;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scroll;

@property (weak, nonatomic) IBOutlet UILabel *emptyNote;

@property (weak, nonatomic) IBOutlet UIButton *warn;
@property(nonatomic,assign) BOOL lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doInit];
    [self bindListener];
    
    

}
-(void)doInit{
    CGRect fra = _warn.frame;
    _warn.frame=(CGRect){-fra.size.width,fra.origin.y,fra.size};
    _warn.enabled=NO;
    
    UIImageView *usernameImgv=[self createImgVWithImage:@"icon_userName" andHLImg:@"icon_username_normal"];
    [_username setLeftView:usernameImgv],
    [_username setLeftViewMode:UITextFieldViewModeAlways];

    UIImageView *passrodImgv=[self createImgVWithImage:@"icon_password" andHLImg:@"icon_password_normal"];
    [_password setLeftView:passrodImgv];
    [_password setLeftViewMode:UITextFieldViewModeAlways];
    
    NSArray *imgary = [self createImgAry:@"Bubble_" from:1 to:5];
    [self animate:_bubble1 repeat:3 interval:.1 ary:imgary];
    [self animate:_bubble2 repeat:3 interval:.1 ary:imgary];
    [self animate:_bubble3 repeat:3 interval:.1 ary:imgary];
    [self animate:_bubble4 repeat:3 interval:.1 ary:imgary];

  
    _lock=NO;
    [self updateView];
}
-(UIImageView *)createImgVWithImage:(NSString *)img andHLImg:(NSString *)hlimg{
    UIImageView *usernameImgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:img]];
    
    [usernameImgv setHighlightedImage:[UIImage imageNamed:hlimg]];
    return usernameImgv;
}

-(void)bindListener{
    [_submit addTarget:self action:@selector(onSubmit:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)animateBubbles{
    
    if(!_bubble1.isAnimating)
        [_bubble1 startAnimating];
    if(!_bubble2.isAnimating)
        [_bubble2 startAnimating];
    if(!_bubble3.isAnimating)
        [_bubble3 startAnimating];
    if(!_bubble4.isAnimating)
        [_bubble4 startAnimating];

}

-(NSArray *)createImgAry:(NSString *)pref from:(int)from to:(int)to{
    NSMutableArray *mary = [NSMutableArray array];
    for(int i=from;i<=to;i++){
        [mary addObject: [UIImage imageNamed:[NSString stringWithFormat:@"%@%02d",pref,i]]];
    }
    return mary;
}
-(void)animate:(UIImageView *)view repeat:(int)count interval:(CGFloat)interval ary:(NSArray *)ary {
    view.animationImages=ary;
    view.animationDuration=interval*ary.count;
    view.animationRepeatCount=count;
    
    
}
-(void)onSubmit:(id)sender{
    [UIView animateWithDuration:.1 animations:^{
        self.submit.transform=CGAffineTransformIdentity;
        self.warn.transform=CGAffineTransformIdentity;
        self.scroll.transform=CGAffineTransformIdentity;
        
    }];
   
    _emptyNote.text=@"";
    NSString *username = _username.text;
    NSString *password = _password.text;
    if(username.length==0){
        _emptyNote.text=@"请输入用户名";
        [_username becomeFirstResponder];
        return ;
    }
    if(password.length==0) {
        
        _emptyNote.text=@"请输入密码";
        [_password becomeFirstResponder];
        return ;
    }
    
    _lock=YES;
    [self updateView];
    
    
    [self performSelector:@selector(loginWithUsernameNPwd:) withObject:[NSString stringWithFormat:@"username=%@&password=%@",username,password] afterDelay:3];
    
}

-(void)sendScroll{
    
    if(_lock){
        _scroll.transform=CGAffineTransformRotate(_scroll.transform, M_PI/8);
        [self performSelector:NSSelectorFromString(@"sendScroll") withObject:nil afterDelay:0.05];
       
    }

}
-(void)loginWithUsernameNPwd:(NSString *)info {
    NSArray *ary = [info componentsSeparatedByString:@"&"];
    NSString *username =[ary[0] componentsSeparatedByString:@"="][1];
    NSString *password = [ary[1] componentsSeparatedByString:@"="][1];
    BOOL result=[username.lowercaseString isEqualToString:@"abc"]&&[password.lowercaseString isEqualToString:@"111"];
    [self performSelectorOnMainThread:@selector(loginResult:) withObject:[NSNumber numberWithBool:result] waitUntilDone:NO];
   
    
   
}
-(void)loginResult:(NSNumber *)flag{
    if(![flag boolValue]){
        [UIView animateWithDuration:.4 animations:^{
            _warn.transform=CGAffineTransformTranslate(_warn.transform, CGRectGetMidX(self.view.frame)-CGRectGetMidX(_warn.frame), 0);
            CGFloat ty=40-CGRectGetMaxY(_warn.frame)+CGRectGetMinY(_submit.frame);
            _submit.transform=CGAffineTransformTranslate(_submit.transform, 0, ty);
            
            _scroll.transform=CGAffineTransformTranslate(_scroll.transform, 0,ty );
        }];

    }
    _lock=NO;
    [self updateView];
}
-(void)updateView{
    
    [self.username setEnabled:!_lock];
    [self.password setEnabled:!_lock];
    [self.submit setEnabled:!_lock];
    ((UIImageView *)_username.leftView).highlighted=_lock;
    ((UIImageView *)_password.leftView).highlighted=_lock;
    if(!_lock)
        [self animateBubbles];
    _scroll.hidden=!_lock;
    [self sendScroll];
    
}



@end
