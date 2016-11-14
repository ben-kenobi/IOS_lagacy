//
//  YFTabBar.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTabBar.h"
#import "ViewController.h"
#import "YFTabB.h"
#import "YFNavCon.h"
#import "HallCon.h"



@interface YFTabBar ()

@end

@implementation YFTabBar


-(void)initUI{
    NSMutableArray *ary=[NSMutableArray array];
    NSString *str[]={@"HallCon",@"AranaCon",@"discovery",@"HisCon",@"MyCon"};
    
    for(int i=0;i<5;i++){
        UIViewController *con;
        if(i!=2)
            con=[[NSClassFromString(str[i]) alloc] init];
        else{
            UIStoryboard *sb=[UIStoryboard storyboardWithName:str[i] bundle:0] ;
            con=[sb instantiateViewControllerWithIdentifier:str[i]];
        }
        UINavigationController *nc=[[YFNavCon alloc] initWithRootViewController:con];
        [ary addObject:nc];
        
    }
    [self setViewControllers:ary];
   
   
    YFTabB *tabb=[[YFTabB alloc] init];
    [tabb setFrame:self.tabBar.bounds];
    for (int i=0;i<5; i++) {
        UIImage* img = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar%d", i + 1]];
        UIImage* imgsel = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar%dSel", i + 1]];
        [tabb addBtnWithImg:img selImg:imgsel];
    }
    [tabb setOnBtnClickedAtIdx:^(NSInteger idx) {
        [self setSelectedIndex:idx];
        
    }];
    [self.tabBar addSubview:tabb];
    

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
}



@end
