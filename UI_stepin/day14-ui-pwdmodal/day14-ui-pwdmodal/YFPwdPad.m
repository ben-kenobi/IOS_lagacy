//
//  YFPwdPad.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFPwdPad.h"
#import "Masonry.h"
@interface YFPwdPad ()

@property (nonatomic,assign) NSInteger len;
@property (nonatomic,strong)NSMutableArray *labs;
@property (nonatomic,weak)UIButton *commit;

@end

@implementation YFPwdPad


+(instancetype)pwdPadWithLen:(NSInteger)len delegate:(id<YFPwdPadDelegate>)delegate{
    YFPwdPad *pp= [[self alloc] initWithLen:len];
    pp.delegate=delegate;
    return pp;
}

-(instancetype)initWithLen:(NSInteger)len{
    if(self=[super init]){
        self.len=len;
        self.labs=[NSMutableArray array];
        
        [self initUI];
        [self initState];
    }
    return self;
}

-(void)append:(NSString *)str{
    if(self.pwd.length<_len){
        [self.pwd appendString:str];
        [self updateUI];
    }
}
-(void)deleteLast{
    if(self.pwd.length>0){
        [self.pwd deleteCharactersInRange:(NSRange){self.pwd.length-1,1}];
        [self updateUI];
        
    }
}
-(void)updateUI{
    for(int i=0;i<self.labs.count;i++){
        [self.labs[i] setText:i<self.pwd.length?@"*":@""];
    }
    self.commit.enabled=self.pwd.length==_len;
}

-(void)initUI{
    for(int i=0;i<_len;i++){
        UILabel *lab =[[UILabel alloc] init];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setTextColor:[UIColor blackColor]];
        [lab setBackgroundColor:[UIColor whiteColor]];
        [lab setFont:[UIFont boldSystemFontOfSize:22]];
        [self addSubview:lab];
        [self.labs addObject:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(-20);
            make.width.height.equalTo(self.mas_width).multipliedBy(1.0/_len).offset(-10.0*(_len+1)/_len);
            if(!i)
                make.left.equalTo(@10);
            else
                make.left.equalTo([[self.labs objectAtIndex:i-1] mas_right]).offset(10);
            
        }];
    }
    
    UIButton *commit=[[UIButton alloc] init];
    [commit setTitle:@"commit" forState:UIControlStateNormal];
    [commit setBackgroundColor:[UIColor cyanColor]];
    [commit setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [commit setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.commit=commit;
    [self addSubview:commit];
    [commit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(.6);
        make.height.equalTo(@40);
        make.left.equalTo(self.mas_right).multipliedBy(.2);
        make.top.equalTo([self.labs.lastObject mas_bottom]).offset(20);
    }];
    
    [commit addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onBtnClicked:(UIButton *)sender{
    [self.delegate onCommit:self.pwd];
}

-(void)initState{
    _pwd=[NSMutableString string];
    
    [self updateUI];
}

@end
