//
//  ViewController.m
//  day07-ui-UITableView
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFBlog.h"
#import "YFBlogF.h"
#import "YFBlogCell.h"

@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *datas;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"123123";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFBlogF *f=self.datas[indexPath.row];
    return f.height;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"blogiden";
    YFBlogCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[YFBlogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell setBlogf:_datas[indexPath.row]];
    return cell;
}

-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
        NSArray  *ary =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"microBlogs" ofType:@"plist"]];
        for(NSDictionary *dict in ary){
            [_datas addObject:[YFBlogF blogFWithblog:[YFBlog blogWithDict:dict] wid:self.tableView.frame.size.width]];
        }
    }
    return _datas;
}

@end
