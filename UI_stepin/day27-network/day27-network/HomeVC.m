//
//  HomeVC.m
//  day27-network
//
//  Created by apple on 15/11/1.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()
@property (nonatomic,weak)UITableView* tv;
@property (nonatomic,weak)UIBarButtonItem *item;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UITableView *tv=[[UITableView alloc] init];
    [self.view addSubview:tv];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:@"logout" style:0 target:self action:@selector(onItemClicked:)];
    UIToolbar *tb=[[UIToolbar alloc] initWithFrame:(CGRect){0,20,self.view.w,44}];
    UIBarButtonItem *itemplace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:0 action:0];
    
    [tb setItems:@[itemplace,item]];
    self.item=item;
    
    [self.view addSubview:tb];
    
}
-(void)onItemClicked:(id)sender{
    if(sender==self.item){
        [IUtil broadcast:LogoutNoti info:0];
        
    }
}


@end
