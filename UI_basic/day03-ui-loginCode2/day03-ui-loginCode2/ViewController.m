//
//  ViewController.m
//  day03-ui-loginCode2
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#define BUBBLETRANSFORM (CGAffineTransformMakeScale(1.4, 1.4))
#define USERNAME @"abc"
#define PASSWORD @"111"

@interface ViewController ()
@property (nonatomic,weak)UITextField *username;
@property (nonatomic,weak)UITextField *password;
@property (nonatomic,weak)UIButton *login;
@property (nonatomic,weak)UIButton *warn;
@property (nonatomic,weak)UIImageView *bg;
@property (nonatomic,assign) BOOL lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
    [self initListeners];
    
}



-(void)initState{
    [self updateVIew:NO];
    
}

-(void)initListeners{
    [self.login addTarget:self  action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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


- (void)onBtnClicked:(UIButton *)sender {
    NSString *username = _username.text;
    NSString *password= _password.text;
    [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.4 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.login.transform=CGAffineTransformIdentity;
        self.warn.transform=CGAffineTransformIdentity;
    } completion:nil];
    
    
    if(username.length==0){
        [[[UIAlertView alloc] initWithTitle:@"note" message:@"pelease input username" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil] show ];
        
        [_username becomeFirstResponder];
        return ;
    }else if(password.length==0){
        [[[UIAlertView alloc] initWithTitle:@"note" message:@"please input password" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil] show ];
        [_password becomeFirstResponder];
        return ;
    }
    
    
    [self loginWithUsername:username pwd:password];
    
}

-(void)loginWithUsername:( NSString *)username pwd:(NSString *)pwd{
    [self updateVIew:YES];
    self.warn.alpha=0;
    [UIView animateWithDuration:0 delay:3 options:0 animations:^{
        self.warn.alpha=.9;
    } completion:^(BOOL finished) {
        BOOL checkName=[[username lowercaseString] isEqualToString:USERNAME];
        BOOL checkPwd=[[pwd lowercaseString] isEqualToString:PASSWORD];
        if(checkPwd&&checkName){
           [[[UIAlertView alloc] initWithTitle:@"note" message:@"login success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            [self updateVIew:NO];
        }else{
            [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.warn.transform=CGAffineTransformMakeTranslation(self.bg.center.x-self.warn.center.x, 0);
                self.login.transform=CGAffineTransformMakeTranslation(0, CGRectGetMaxY(self.warn.frame)-CGRectGetMinY(self.login.frame)+40);
            } completion:^(BOOL finished) {
                [self updateVIew:NO];
            }];
           
            
        }
        
    }];
    
    
    
}



-(void)startBubble{
    [UIView animateWithDuration:.7 animations:^{
        for(int i=1;i<=5;i++){
            [_bg viewWithTag:i].transform=BUBBLETRANSFORM;
        }
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            for(int i=1;i<=5;i++){
                [_bg viewWithTag:i].transform=CGAffineTransformIdentity;
            }
            
        } completion:nil];
    }];
}



-(void)initUI{
    int i;
    UIImageView *bg= [[UIImageView alloc] initWithFrame:self.view.frame];
    bg.image=[UIImage imageNamed:@"background_image"];
    [bg setUserInteractionEnabled:YES];
    [self.view addSubview:bg];
    self.bg=bg;
    
    CGPoint center=self.bg.center;
    
    CGRect rects[]={{center.x/2-80,center.y/2-80,80,80},{center.x-40,center.y-100,95,95},{center.x-80,center.y-80,105,105},{center.x-100,center.y+40,130,130},{center.x+30,center.y*2-180,110,110}};
    
    UIImageView *(^createBubble)(CGRect,NSString*,int,UIView *)=
    ^(CGRect fra,NSString *img,int tag,UIView *supV){
        UIImageView *iv=[[UIImageView alloc] initWithFrame:fra];
        iv.image=[UIImage imageNamed:img];
        iv.tag=tag;
        [supV addSubview:iv];
        return iv;
    };
    
    for(i=1;i<=sizeof(rects)/sizeof(rects[0]);i++){
        createBubble(rects[i-1],[NSString stringWithFormat:@"%@%02d",@"Bubble_",i],i,self.bg);
    }
    
    UITextField *(^createTF)(CGRect,NSString *,UIView *,UIView *)=
    ^(CGRect fra,NSString *placeh,UIView *lv,UIView *supV){
        UITextField *tf=[[UITextField alloc] initWithFrame:fra];
        [tf setPlaceholder:placeh];
        [tf setBackground:[UIImage imageNamed:@"textField_border"]];
        [tf setDisabledBackground:[UIImage imageNamed:@"textField_normal"]];
        tf.leftView=lv;
        [tf setLeftViewMode:UITextFieldViewModeAlways];
        [supV addSubview:tf];
        return tf;
    };
    UIImageView *(^createIV)(CGRect,NSString *,NSString *)=^(CGRect fra,NSString *img,NSString *hlimg){
        
        UIImageView *iv=[[UIImageView alloc] initWithFrame:fra];
        
        [iv setImage:[UIImage imageNamed:img]];
        [iv setHighlightedImage:[UIImage imageNamed:hlimg]];
        return iv;
    };
    UIView *(^createTFLV)(CGRect,NSString*,NSString *)=^(CGRect fra,NSString *img,NSString *hlimg){
        UIView *v=[[UIView alloc] initWithFrame:fra];
        CGRect rect={5,5,fra.size.width-10,fra.size.height-10};
        [v addSubview:createIV(rect ,img, hlimg)];
        return v;
    };
    
    CGFloat tfH=33;
    CGRect usernameRect={center.x/4,70,center.x/2*3,tfH},
    passwordRect={center.x/4,70+tfH+20,center.x/2*3,tfH};
    
    self.username=createTF(usernameRect,@"Username",createTFLV((CGRect){0,0,tfH,tfH},@"icon_userName" ,@"icon_username_normal"),self.bg);
    self.password=createTF(passwordRect,@"Password",createTFLV((CGRect){0,0,tfH,tfH} ,@"icon_password" ,@"icon_password_normal"),self.bg);
    
    
    
    UIButton *(^createBtn)(CGRect,NSString *,NSString *,UIView *)=^(CGRect fra,NSString *tit,NSString *bg,UIView *supV){
        UIButton *btn=[[UIButton alloc] initWithFrame:fra];
        [btn setBackgroundImage:[UIImage imageNamed:bg] forState:UIControlStateNormal];
        [btn setTitle:tit forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        btn.titleLabel.shadowColor=[UIColor colorWithRed:.4 green:.8 blue:.8 alpha:1];
        btn.titleLabel.shadowOffset=(CGSize){2,-2};
        [btn setAdjustsImageWhenHighlighted:NO];
        [supV addSubview:btn];
        return btn;
    };
    
    
    CGRect lgRec={center.x/4,CGRectGetMaxY(self.password.frame)+30,center.x/2*3,55},
    warnRec={-center.x/2*3,CGRectGetMaxY(self.password.frame)+20,center.x/2*3,55};
    self.login=createBtn(lgRec,@"Log in",@"login_button",self.bg);
    self.warn=createBtn(warnRec,@"Invalid Username or Pwd",@"warning_button",self.bg);
    [self.warn setUserInteractionEnabled:NO];
    
    UIActivityIndicatorView *roller = [[UIActivityIndicatorView alloc] init];
    roller.center=(CGPoint){25,CGRectGetMidY(_login.bounds)};
    [_login addSubview:roller];
    [roller setHidesWhenStopped:YES];
    roller.tag=1;
    [roller setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    
    
}



@end
