//
//  ViewController.m
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFTvAdapter.h"
#import "YFFooter.h"
#import "YFTgHeader.h"

@interface ViewController ()<YFFooterDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) UITableView *tv;
@property (nonatomic,strong) YFTvAdapter * tvAdap;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
   
}

-(void)initState{
    

}



-(void)loadMoreDidClicked:(YFFooter *)footer{
    [self.tvAdap appendData:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"]]];
    [self.tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.tvAdap.data.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


-(void)initUI{
    CGRect frame=self.view.frame;
    UITableView *tv=[[UITableView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, frame.size.height) style:UITableViewStylePlain];
    [tv setRowHeight:70];
    [self.view addSubview:tv];
    self.tv=tv;
    
    
    NSArray * ary=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tgs" ofType:@"plist"]];
    self.tvAdap=[YFTvAdapter adapterWithData:ary tableView:self.tv];
    
    self.tv.delegate=self.tvAdap;
    self.tv.dataSource=self.tvAdap;
    
    YFTgHeader *header=[[NSBundle mainBundle] loadNibNamed:@"YFTgHeaderView" owner:nil options:nil][0];
    self.tv.tableHeaderView=header;
    [header initUI:self];
  

    

    
    
    YFFooter *footer=[[NSBundle mainBundle] loadNibNamed:@"YFTgFooterView" owner:nil options:nil][0];
    [footer initListener];
    footer.delegate=self;
    [self.tv setTableFooterView:footer];
    
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    YFTgHeader *header= (YFTgHeader *)self.tv.tableHeaderView;
    UIScrollView *sv=header.sv;
    [header.pageIndi setCurrentPage:[sv contentOffset].x/sv.frame.size.width ];
    [header startTImer];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    YFTgHeader *header=(YFTgHeader *)self.tv.tableHeaderView;
    [header.timer invalidate];
    
}

@end
