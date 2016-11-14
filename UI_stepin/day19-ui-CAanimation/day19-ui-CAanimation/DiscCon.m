//
//  DiscCon.m
//  day19-ui-CAanimation
//
//  Created by apple on 15/10/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "DiscCon.h"
#import "DIscCon_sub1.h"
#import "ViewController.h"
#import "LuckyNumCon.h"

@interface DiscCon ()

@end

@implementation DiscCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"discovery";
    [self initUI];
}

-(void)initUI{
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
//        [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
        [[self navigationController] showViewController:[[ViewController alloc] init] sender:nil];
    }else if(indexPath.section==0){
        DIscCon_sub1 *con=[[DIscCon_sub1 alloc] init];
        [[self navigationController] showViewController:con sender:nil];
    }else if(indexPath.section==1){
        LuckyNumCon *con=[[LuckyNumCon alloc] init];
        [[self navigationController] showViewController:con sender:nil];
    }
}




@end
