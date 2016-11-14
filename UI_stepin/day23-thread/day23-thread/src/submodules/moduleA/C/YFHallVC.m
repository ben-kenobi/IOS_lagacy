//
//  YFHallVC.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/19.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHallVC.h"
#import "YFSettingVC.h"

@interface YFHallVC ()
@property (nonatomic,weak)UIBarButtonItem *ritem;
@property (nonatomic,weak)YFSettingVC *settingVC;

@end

@implementation YFHallVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor randomColor]];
    
    UIBarButtonItem *ritem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Mylottery_config"] style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
    self.navigationItem.rightBarButtonItem=ritem;
    self.ritem=ritem;
}

-(void)onItemClicked:(id)sender{
   YFSettingVC *vc= [[YFSettingVC alloc] init];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:@selector(help:)];
    [vc navigationItem].rightBarButtonItem=item;
    self.settingVC=vc;
    SEL sel=NSSelectorFromString(@"setPname:");
    if([vc respondsToSelector:sel]){
        [vc performSelector:sel withObject:@"setting.plist" ];
    }
    [self.navigationController showViewController:vc sender:nil];
}


-(void)help:(id)sender{
    [self.settingVC.navigationController showViewController:[[NSClassFromString(@"YFHelpVC") alloc] init] sender:nil];
}
@end
