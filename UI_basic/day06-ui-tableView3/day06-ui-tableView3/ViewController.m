//
//  ViewController.m
//  day06-ui-tableView3
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFHeroTvAdapter.h"
#import "YFHeroMod.h"
@interface ViewController ()
@property (nonatomic ,weak)UITableView *tv;
@property (nonatomic,strong)id<UITableViewDelegate,UITableViewDataSource> adapter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tv=tv;
    [tv setRowHeight:60];
    [tv setSeparatorColor:[UIColor cyanColor]];
    [tv setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [tv setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
   
    NSArray * ary=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"heros" ofType:@"plist"]];
    self.adapter=[YFHeroTvAdapter adapterWithTv:tv adnData:ary];
    tv.delegate=self.adapter    ;
    tv.dataSource=self.adapter;
    [self.view addSubview:tv];

    
}




-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
