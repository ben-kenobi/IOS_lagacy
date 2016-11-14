//
//  ViewController.m
//  day10-ui-blogAutolayout
//
//  Created by apple on 15/9/26.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFMicroBlog.h"
#import "YFBlogCell.h"

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setEstimatedRowHeight:33];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFBlogCell cellWithTv:tableView blog:_datas[indexPath.row]];
}


-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
        for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"microBlogs.plist" ofType:nil]])
            [_datas addObject:[YFMicroBlog blogWithDict:dict]];
        
    }
    return _datas;
}


@end
