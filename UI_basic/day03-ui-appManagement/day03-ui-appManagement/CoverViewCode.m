//
//  CoverViewCode.m
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "CoverViewCode.h"
#import "AppMod.h"
@interface CoverViewCode()

@property (strong, nonatomic) UIActivityIndicatorView *roller;
@property (strong,nonatomic) UILabel *appName;

@end

@implementation CoverViewCode

-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self setBackgroundColor:[UIColor blackColor]];
    CGPoint center=self.center;
   
    
    self.lab=[[UILabel alloc] initWithFrame:self.frame];
    _lab.font=[UIFont boldSystemFontOfSize:23];
    _lab.textAlignment=NSTextAlignmentCenter;
    _lab.textColor=[UIColor whiteColor];
    _lab.shadowColor=[UIColor colorWithRed:.3 green:.5 blue:.1 alpha:1];
    _lab.shadowOffset=(CGSize){1,-2};
    [self addSubview:self.lab];
    
    self.appName=[[UILabel alloc] initWithFrame:(CGRect){0,center.y-50,center.x*2,40}];
    _appName.textColor=[UIColor colorWithRed:.9 green:.3 blue:.3 alpha:1];
    _appName.textAlignment=NSTextAlignmentCenter;
    _appName.font=[UIFont boldSystemFontOfSize:22];
    _appName.shadowColor=[UIColor colorWithRed:.3 green:.5 blue:.1 alpha:1];
    _appName.shadowOffset=(CGSize){1,-2};
    [self addSubview:self.appName];
    
    self.roller =[[UIActivityIndicatorView alloc] init];
    self.roller.center=(CGPoint){center.x,CGRectGetMinY(self.appName.frame)-50};
    [self.roller setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.roller.color=[UIColor cyanColor];
    self.roller.hidesWhenStopped=YES;
    [self.roller startAnimating ];
    [self addSubview:self.roller];
    
    
    
}

+(instancetype)viewWithFrame:(CGRect)frame andMod:(AppMod *) mod{
    CoverViewCode *obj= [[self alloc] initWithFrame:frame];
    obj.mod=mod;
    return obj;
}


-(void)setMod:(AppMod *)mod{
    if(_mod!=mod){
        _mod=mod;
        self.appName.text=mod.title;
        
    }
}

@end
