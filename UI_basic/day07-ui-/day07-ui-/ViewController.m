//
//  ViewController.m
//  day07-ui-
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFTvAdapter.h"
#import "YFTgFooter.h"
#import "YFTgHeader.h"

@interface ViewController ()<YFTgFooterDelegate>
@property (nonatomic,weak) UITableView *tv;
@property (nonatomic,strong) YFTvAdapter *tvAdap;
@property (nonatomic,weak) YFTgHeader *header;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    CGRect frame=self.view.frame;
    frame.origin.y+=17;
    UITableView *tv=[[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tv];
    [tv setSeparatorColor:[UIColor cyanColor]];
    [tv setSeparatorInset:(UIEdgeInsets){0,10,0,10}];
    self.tv=tv;
    
    self.tvAdap=[YFTvAdapter adapterWithDatas:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tgs" ofType:@"plist"]] andTv:self.tv];
    self.tv.delegate=self.tvAdap;
    self.tv.dataSource=self.tvAdap;
    YFTgFooter *footer=[YFTgFooter footerWithFrame:CGRectMake(0, 0, 0, 60) andTv:self.tv];
    [footer setDelegate:self];
    
    self.header=[YFTgHeader headerWithFrame:CGRectMake(0, 0, 0, 120) andImgs:@[@"ad_00",@"ad_01",@"ad_02"] andTv:self.tv];
    
}

-(void)loadMoreDidClicked:(YFTgFooter *)footer{
   NSInteger index= [_tvAdap loadMore:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tgs" ofType:@"plist"]]];
    [self.tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    [self.header appendImgs:@[@"ad_03",@"ad_04"]];
   
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
