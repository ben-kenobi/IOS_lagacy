//
//  ViewController.m
//  day09-ui-wechatlist
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

#import "YFFriend.h"
#import "YFFriendList.h"

#import "YFHFview.h"

@interface ViewController ()<HFVDelegate>

@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YFFriendList *list= _datas[section];
    return list.isHide?0: list.friends.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"friendlistiden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cell){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    
    YFFriendList *list=_datas[indexPath.section];
    YFFriend *fri=list.friends[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:fri.icon];
    cell.textLabel.text=fri.name;
    cell.detailTextLabel.text=fri.intro;
    if([fri isVip]){
        [cell.textLabel setTextColor:[UIColor redColor]];
    }else{
        [cell.textLabel setTextColor:[UIColor blackColor]];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *iden=@"friendhfiden";
    YFHFview *hfv=[tableView dequeueReusableHeaderFooterViewWithIdentifier:iden];
    if(nil==hfv){
        hfv=[[YFHFview alloc] initWithReuseIdentifier:iden];
        hfv.delegate=self;
    }
    [hfv setMod:_datas[section]];
    hfv.tag=section;
    return hfv;
}


-(void)toggleList:(YFHFview *)hfv{
    NSInteger section=hfv.tag;
    
   [self.tableView reloadSections:[NSIndexSet  indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}



-(void)initUI{
    [self.tableView setSectionHeaderHeight:40];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}


-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
        for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil]]){
            [_datas addObject:[YFFriendList listWithDict:dict]];
        }
    }
    return _datas;
}

@end
