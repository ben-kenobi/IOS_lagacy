//
//  YFSearchVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSearchVC.h"
#import "UIBarButtonItem+Ex.h"
#import "MJRefresh.h"
@interface YFSearchVC ()<UISearchBarDelegate>

@end

@implementation YFSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self.navigationController action:@selector(popViewControllerAnimated:) img:img(@"icon_back") hlimg:img(@"icon_back_highlighted")];
    UISearchBar *sb=[[UISearchBar alloc] init];
     sb.tintColor=iColor(32,191,179, 1);
 
    sb.placeholder=@"请输入关键词";
    sb.delegate=self;
    self.navigationItem.titleView=sb;
  
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.collectionView headerBeginRefreshing];
    [searchBar resignFirstResponder];
}

-(NSMutableDictionary *)param{
  return   [NSMutableDictionary dictionaryWithDictionary:@{@"city":self.city,@"keyword":[(UISearchBar *)self.navigationItem.titleView text]}];
}






@end
