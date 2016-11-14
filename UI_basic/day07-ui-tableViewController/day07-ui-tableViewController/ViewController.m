//
//  ViewController.m
//  day07-ui-tableViewController
//
//  Created by apple on 15/9/21.
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

-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
        NSArray *ary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"microBlogs.plist" ofType:nil]];
        for(NSDictionary *dict in ary){
            [_datas addObject:[YFBlogF blogFWithBlog:[YFBlog blogWithDict:dict] wid:self.tableView.frame.size.width]];
        }
    }
    return _datas;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *blogiden=@"blogiden";
    YFBlogCell *cell=[tableView dequeueReusableCellWithIdentifier:blogiden];
    if(nil==cell){
        cell=[[YFBlogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blogiden];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell setBlogf:_datas[indexPath.row]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFBlogF *f=_datas[indexPath.row];
    return f.height;
}



@end
