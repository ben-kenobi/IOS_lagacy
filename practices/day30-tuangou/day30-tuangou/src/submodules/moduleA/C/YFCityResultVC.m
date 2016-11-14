//
//  YFCityResultVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCityResultVC.h"
#import "YFCity.h"
#import "YFMetaTool.h"
#import "YFConst.h"

@interface YFCityResultVC ()
@property (nonatomic,strong)NSMutableArray *cities;
@end

@implementation YFCityResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)setSearchText:(NSString *)searchText{
    _searchText=[searchText copy];
    searchText=searchText.lowercaseString;
    self.cities=[NSMutableArray array];
    for(YFCity *city in [YFMetaTool cities]){
        if([city.name containsString:searchText]||[city.pinYin containsString:searchText]|[city.pinYinHead containsString:searchText]){
            [self.cities addObject:city];
        }
    }
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *iden=@"cityresultcelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    
    YFCity *city=self.cities[indexPath.row];
    cell.textLabel.text=city.name;
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"搜索到%ld个匹配的结果",self.cities.count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YFCity *city=self.cities[indexPath.row];
    if(self.onchange){
        self.onchange(city.name);
    }
    [self dismissViewControllerAnimated:YES completion:0];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];
}

@end
