//
//  ViewController.m
//  day07-ui-microBlog
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFMicroBlog.h"
#import "YFBLogCell.h"
#import "YFBlogF.h"


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
        NSArray *ary=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"microBlogs" ofType:@"plist"]];
        
        for(NSDictionary *dict in ary){
            [_datas addObject:[YFBlogF blogFWithBlog:[YFMicroBlog blogWithDict:dict] wid:self.tableView.frame.size.width]];
        }
    }
    return _datas;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"blogIden";
    
    YFBLogCell *cell =[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell=[[YFBLogCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
   
    
    cell.blogF= self.datas[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFBlogF *f= self.datas[indexPath.row];
    
    return f.height;
}




@end
