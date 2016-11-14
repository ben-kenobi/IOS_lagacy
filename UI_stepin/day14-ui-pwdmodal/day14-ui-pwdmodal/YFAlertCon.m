//
//  YFAlertCon.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAlertCon.h"
#import "Masonry.h"
#import "YFView.h"
#import "YFAlerV.h"
@interface YFAlertCon ()

@property (nonatomic,weak)YFAlerV *main;

@property (nonatomic,copy)NSString *message;

@property (nonatomic,strong)NSMutableArray *btns;


@end

@implementation YFAlertCon


-(NSMutableArray *)btns{
    if(!_btns){
        _btns=[NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)tfs{
    if(!_tfs){
        _tfs=[NSMutableArray array];
    }
    return _tfs;
}

-(void)addTfWithConf:(void (^)(UITextField *))conf{
    [self.tfs addObject:conf];
}

-(void)addBtn:(NSString *)title action:(void (^)())action{
    [self.btns addObject:@{@"title":title,@"action":action}];
}

-(void)loadView{
    self.view=[[YFView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.7]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initListeners];
}
-(void) initListeners{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKBChange:) name:UIKeyboardWillChangeFrameNotification object:0];
}
-(void)onKBChange:(NSNotification *)noti{
    CGFloat dura=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endframe=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:dura animations:^{
        self.main.transform=CGAffineTransformMakeTranslation(0,endframe.origin.y-CGRectGetMaxY(self.main.frame));
    }];
}


-(void)initUI{
    YFAlerV *main=[[YFAlerV alloc] init];
    [main setBackgroundColor:[UIColor clearColor]];
    [main.layer setBackgroundColor:[[UIColor whiteColor] CGColor] ];
    [main.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [main.layer setBorderWidth:1];
    [main.layer setCornerRadius:10];
    [main.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [main.layer setShadowRadius:5];
    [main.layer setShadowOffset:(CGSize){8,8}];
    [main.layer setShadowOpacity:.6];
    [self.view addSubview:main];
    self.main=main;
    [main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view.mas_width).multipliedBy(.75);
    }];
    main.title=self.title;
    main.message=self.message;

    
    CGFloat top=65,pad=8,tfh=33,btnh=44;
    for(int i=0;i<self.tfs.count;i++){
        UITextField *tf=[[UITextField alloc] init];
        ((void(^)(UITextField *))self.tfs[i])(tf);
        [main addSubview:tf];
        self.tfs[i]=tf;
        tf.layer.cornerRadius=5;
        tf.layer.borderColor=[[UIColor grayColor] CGColor];
        tf.layer.borderWidth=.7;
        tf.layer.shadowColor=[[UIColor grayColor]CGColor];
        tf.layer.shadowOffset=(CGSize){-1,-1};
        tf.layer.shadowOpacity=1;
        tf.layer.shadowRadius=3;
        tf.leftView=[[UIView alloc] initWithFrame:(CGRect){0,0,7,0}];
        tf.leftViewMode=UITextFieldViewModeAlways;
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.height.equalTo(@(tfh));
            make.width.equalTo(main).multipliedBy(.85);
            make.top.equalTo(@(top+(pad+tfh)*i));
        }];
    }
    if(!self.tfs.count){
        UITextField *tf=[[UITextField alloc] init];
        [main addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.height.equalTo(@(0));
            make.width.equalTo(@0);
            make.top.equalTo(@(top));
        }];
        [self.tfs addObject:tf];
    }
    
    UIButton *pre;
    for(int i=0;i<self.btns.count;i++){
        UIButton *btn=[[UIButton alloc] init];
        [btn setTitle:_btns[i][@"title"] forState:UIControlStateNormal] ;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        btn.layer.borderColor=[[UIColor grayColor]CGColor];
        btn.layer.borderWidth=.3;
        [self.main addSubview:btn];
        [btn addTarget:self action:@selector(ontBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag=i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(btnh));
            make.bottom.equalTo(@0);
            make.top.equalTo([self.tfs.lastObject mas_bottom]).offset(18);
            make.left.equalTo(pre?[pre mas_right]:@0);
            if(pre)
                make.width.equalTo(pre);
        }];
        if(i==self.btns.count-1){
            [btn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@0);
            }];
        }
        pre=btn;
    }
    
    
   
}

-(void)ontBtnClicked:(UIButton *)sender{
    ((void (^)(YFAlertCon *))self.btns[sender.tag][@"action"])(self);
    [self dismissViewControllerAnimated:YES completion:0];
}




-(instancetype)initWithTitle:(NSString *)title mes:(NSString *)mes{
    if(self=[super init]){
        self.title=title;
        self.message=mes;
    }
    return self;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
