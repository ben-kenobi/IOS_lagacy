//
//  YFDetailVC.m
//  day35-exam
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDetailVC.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"

@interface YFDetailVC ()
@property (nonatomic,strong)NSDictionary *dict;

@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,weak)UILabel *name;
@property (nonatomic,weak)UILabel *intro;

@end

@implementation YFDetailVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    UIImageView *iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
    self.iv=iv;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@120);
        make.centerX.equalTo(@0);
        make.top.equalTo(@50);
    }];
    
    UILabel *(^newlab)(UIFont *)=^(UIFont *font){
        UILabel *lab=[[UILabel alloc] init];
        [self.view addSubview:lab];
        lab.font=font;
        [lab setNumberOfLines:0];
        [lab setTextAlignment:NSTextAlignmentCenter];
        return lab;
    };
    
    self.name=newlab([UIFont systemFontOfSize:17]);
    self.intro=newlab([UIFont systemFontOfSize:13]);
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv.mas_bottom).offset(30);
        make.centerX.equalTo(@0);
    }];
    [self.intro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(60);
        make.centerX.equalTo(@0);
        make.width.lessThanOrEqualTo(self.view).multipliedBy(.8);
    }];

    
    [self loadData];
}
-(void)loadData{
    [iApp setNetworkActivityIndicatorVisible:YES];
    [IUtil get:iURL(([NSString stringWithFormat:@"http://localhost/hero/getHero.php?heroId=%@",self.hid])) cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        [iApp setNetworkActivityIndicatorVisible:NO];
        if(data&&!error){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            [self setDict:dict];
        }else{
            [MBProgressHUD showError:@"error"];
        }
    }];
}

-(void)updateUI{;
    
    self.name.text=_dict[@"name"];
    self.intro.text=_dict[@"intro"];
    [self.iv sd_setImageWithURL:iURL(_dict[@"icon"])];
    
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}


@end
