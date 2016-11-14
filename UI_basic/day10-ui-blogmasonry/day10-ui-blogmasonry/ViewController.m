//
//  ViewController.m
//  day10-ui-blogmasonry
//
//  Created by apple on 15/9/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFBlog.h"
#import "YFBlogCell.h"
@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    [self.tableView setEstimatedRowHeight:33];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFBlogCell cellWithTv:tableView andBlog:_datas[indexPath.row]];
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"microBlogs.plist" ofType:nil]]){
            [_datas addObject:[YFBlog blogWithDict:dict]];
        }
    }
    return _datas;
}

@end
