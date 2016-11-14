//
//  SDBasicTableViewController.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */

#import "SDBasicTableViewController.h"
#import "SDBasicTableViewControllerCell.h"

@implementation SDBasicTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _refreshMode = SDBasicTableViewControllerRefeshModeNone;
        _sectionsNumber = 1;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:(245 / 255.0) green:(245 / 255.0) blue:(245 / 255.0) alpha:1];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self setupRefreshMode];
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.tableView reloadData];
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass description]];
}

- (void)setRefreshMode:(SDBasicTableViewControllerRefeshMode)refreshMode
{
    _refreshMode = refreshMode;
    
    [self setupRefreshMode];
}

- (void)setupRefreshMode
{
    switch (_refreshMode) {
        case SDBasicTableViewControllerRefeshModeNone:
        {
            ;
        }
            break;
            
        case SDBasicTableViewControllerRefeshModeHeaderRefresh:
        {
            UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
            [refresh addTarget:self action:@selector(pullDownRefreshOperation) forControlEvents:UIControlEventValueChanged];
            self.refreshControl = refresh;
        }
            break;
            
        case SDBasicTableViewControllerRefeshModeFooterRefresh:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionsNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = (self.sectionsNumber == 1) ? self.dataArray.count : [self.dataArray[section] count];
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDBasicTableViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.cellClass description]];
    if (!cell) {
        cell = [[self.cellClass alloc] init];
    }
    if (self.sectionsNumber == 1) {
        cell.model = self.dataArray[indexPath.row];
    } else if (self.sectionsNumber > 1){
        cell.model = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - funcs for subControllers rewrite

- (void)pullDownRefreshOperation
{
    
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com