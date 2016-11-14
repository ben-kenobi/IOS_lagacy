//
//  RootViewController.m
//  TestSendMessageBetweenObject
//
//  Created by qianfeng on 14-6-27.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "TestUseDelegateVC.h"
#import "TestUseBlockVC.h"
#import "TestUseNotificationVC.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *itemArr_;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        itemArr_ = [NSArray arrayWithObjects:@"delegate",@"block",@"notification", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"对象间的消息传递";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemArr_ count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = [itemArr_ objectAtIndex:indexPath.row];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [itemArr_ objectAtIndex:indexPath.row];
    if([str isEqualToString:@"delegate"])
    {
        TestUseDelegateVC *edvc = [[TestUseDelegateVC alloc] init];
        [self.navigationController pushViewController:edvc animated:YES];
        
    }
    else if([str isEqualToString:@"block"])
    {
        TestUseBlockVC *edvc = [[TestUseBlockVC alloc] init];
        [self.navigationController pushViewController:edvc animated:YES];
        
    }
    else if([str isEqualToString:@"notification"])
    {
        TestUseNotificationVC *edvc = [[TestUseNotificationVC alloc] init];
        [self.navigationController pushViewController:edvc animated:YES];
        
    }
}



@end
