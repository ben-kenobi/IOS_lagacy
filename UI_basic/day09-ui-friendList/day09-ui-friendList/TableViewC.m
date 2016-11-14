//
//  TableViewC.m
//  day09-ui-friendList
//
//  Created by apple on 15/9/25.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "TableViewC.h"
#import "YFApp.h"
#import "YFAppCell2.h"

@interface TableViewC ()
@property (nonatomic,strong)NSMutableArray *datas;


@end

@implementation TableViewC



- (void)viewDidLoad {
    [super viewDidLoad];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFAppCell2 cellWithTv:tableView andMod:_datas[indexPath.row]];
}

-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
        for(NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps_full.plist" ofType:nil]]){
            [_datas addObject:[YFApp appWithDict:dict] ];
        }
    }
    return _datas;
}

@end
