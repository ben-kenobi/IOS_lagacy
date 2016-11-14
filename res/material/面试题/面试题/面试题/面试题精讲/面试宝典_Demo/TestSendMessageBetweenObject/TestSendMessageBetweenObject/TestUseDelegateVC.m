//
//  TestUseDelegateVC.m
//  TestSendMessageBetweenObject
//
//  Created by qianfeng on 14-6-27.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "TestUseDelegateVC.h"
#import "TestDeclareDelegateVC.h"

@interface TestUseDelegateVC ()<UITableViewDelegate,UITableViewDataSource,TestDeclareDelegateVCDelegate>
{
    NSMutableArray  *itemArr_;
    NSIndexPath     *selectItem_;
    
    IBOutlet UITableView *tableView_;
}
@end

@implementation TestUseDelegateVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        itemArr_ = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString:@"FFFFFF"],@"FFFFFF",@"FFFFFF",@"FFFFFF",@"FFFFFF",@"FFFFFF", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    TestDeclareDelegateVC *ddvc = [[TestDeclareDelegateVC alloc] init];
    ddvc.delegate = self;
    ddvc.content = [itemArr_ objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ddvc animated:YES];
    
    selectItem_ = indexPath;
}

#pragma TestDeclareDelegateVCDelegate

-(void)completeTask:(id)obj
{
    [itemArr_ replaceObjectAtIndex:selectItem_.row withObject:obj];
    
    [tableView_ reloadRowsAtIndexPaths:[NSArray arrayWithObject:selectItem_] withRowAnimation:UITableViewRowAnimationFade];
}


@end
