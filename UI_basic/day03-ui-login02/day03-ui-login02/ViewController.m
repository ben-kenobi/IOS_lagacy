//
//  ViewController.m
//  day03-ui-login02
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#define BUBBLETRANSFORM (CGAffineTransformMakeScale(1.4, 1.4))
#define USERNAME @"abc"
#define PASSWORD @"111"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *b1;
@property (weak, nonatomic) IBOutlet UIImageView *b2;
@property (weak, nonatomic) IBOutlet UIImageView *b3;
@property (weak, nonatomic) IBOutlet UIImageView *b4;
@property (weak, nonatomic) IBOutlet UIImageView *b5;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *waning;
@property (assign,nonatomic) BOOL lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self doInit];
}

-(void)setupUI{
    _username.leftView=[self txtFieldLvWithFrame:(CGRect){0,0,_username.frame.size.height,_username.frame.size.height} img:@"icon_userName" HLImg:@"icon_username_normal"];
    _password.leftView=[self txtFieldLvWithFrame:(CGRect){0,0,_password.frame.size.height,
    _password.frame.size.height} img:@"icon_password" HLImg:@"icon_password_normal"];
    [_username setLeftViewMode:UITextFieldViewModeAlways];
   
    [_password setLeftViewMode:UITextFieldViewModeAlways];
    
    UIActivityIndicatorView *roller = [[UIActivityIndicatorView alloc] init];
    roller.center=(CGPoint){25,CGRectGetMidY(_login.bounds)};
    [_login addSubview:roller];
    [roller setHidesWhenStopped:YES];
    roller.tag=1;
    [roller setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    
}

-(void)doInit{
    [self updateVIew:NO];
}

-(void)startBubble{
    [UIView animateWithDuration:.7 animations:^{
        self.b1.transform=BUBBLETRANSFORM;
        self.b2.transform=BUBBLETRANSFORM;
        self.b3.transform=BUBBLETRANSFORM;
        self.b4.transform=BUBBLETRANSFORM;
        self.b5.transform=BUBBLETRANSFORM;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.b1.transform=CGAffineTransformIdentity;
            self.b2.transform=CGAffineTransformIdentity;
            self.b3.transform=CGAffineTransformIdentity;
            self.b4.transform=CGAffineTransformIdentity;
            self.b5.transform=CGAffineTransformIdentity;

        } completion:nil];
    }];
}
-(void)updateVIew:(BOOL)lock{
    _lock=lock;
    _username.enabled=!_lock;
    _password.enabled=!_lock;
    _login.enabled=!_lock;
    ((UIImageView *)_username.leftView.subviews[0]).highlighted=_lock;
    ((UIImageView *)_password.leftView.subviews[0]).highlighted=_lock;
    if(!_lock){
        [self startBubble];
        [((UIActivityIndicatorView *)[_login viewWithTag:1]) stopAnimating];
    }else {
        [((UIActivityIndicatorView *)[_login viewWithTag:1])startAnimating ];
    }
}
- (IBAction)onLogin:(UIButton *)sender {
    NSString *username = _username.text;
    NSString *password= _password.text;
    [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.login.transform=CGAffineTransformIdentity;
        self.waning.transform=CGAffineTransformIdentity;
    } completion:nil];
   
    
    if(username.length==0){
        
        [self showAlertWithTitle:@"notice" text:@"please input username" btn:@[@"cancel"]];
        [_username becomeFirstResponder];
        return ;
    }else if(password.length==0){
        [self showAlertWithTitle:@"notice" text:@"please input password" btn:@[@"cancel"]];
        [_password becomeFirstResponder];
        return ;
    }
    
    
    [self loginWithUsername:username pwd:password];
    
}

-(void)loginWithUsername:( NSString *)username pwd:(NSString *)pwd{
    [self updateVIew:YES];
    self.waning.alpha=0;
    [UIView animateWithDuration:0 delay:3 options:0 animations:^{
       self.waning.alpha=.9;
    } completion:^(BOOL finished) {
        BOOL checkName=[[username lowercaseString] isEqualToString:USERNAME];
        BOOL checkPwd=[[pwd lowercaseString] isEqualToString:PASSWORD];
        if(checkPwd&&checkPwd){
            [self showAlertWithTitle:@"note" text:@"login success" btn:@[@"OK"]];
            [self updateVIew:NO];
        }else{
            [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.waning.transform=CGAffineTransformMakeTranslation(self.view.center.x-self.waning.center.x, 0);
                self.login.transform=CGAffineTransformMakeTranslation(0,40-CGRectGetMinY(self.login.frame)+CGRectGetMaxY(self.waning.frame));
            } completion:^(BOOL finished) {
                [self updateVIew:NO];
            }];
        }
        
    }];
   
    
    
}
-(void)showAlertWithTitle:(NSString *)title text:(NSString *)text btn:(NSArray *)btns{
    UIAlertView *view=[[UIAlertView alloc] initWithTitle:title message:text delegate:nil cancelButtonTitle:btns[0] otherButtonTitles:nil, nil];
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [view show];
    } completion:nil];
    
}

-(UIView *)txtFieldLvWithFrame:(CGRect)frame img:(NSString *)img HLImg:(NSString *)hlimg{
    UIView *v=[[UIView alloc] initWithFrame:frame];
    CGRect rect={5,5,frame.size.width-10,frame.size.height-10};
    [v addSubview:[self imageViewWithFrame:rect img:img HLImg:hlimg]];
    return v;
}
-(UIImageView *)imageViewWithFrame:(CGRect)frame img:(NSString *)img HLImg:(NSString *)hlimg{
    UIImageView *iv=[[UIImageView alloc] initWithFrame:frame];
   
    [iv setImage:[UIImage imageNamed:img]];
    [iv setHighlightedImage:[UIImage imageNamed:hlimg]];
     return iv;
}
@end
