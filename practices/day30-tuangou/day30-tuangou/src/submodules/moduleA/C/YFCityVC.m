//
//  YFCityVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCityVC.h"
#import "UIBarButtonItem+Ex.h"
#import "YFCityGroup.h"
#import "MJExtension.h"
#import "YFCityResultVC.h"
#import "YFMetaTool.h"

@interface YFCityVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UISearchBar *sb;
@property (nonatomic,strong)UITableView *tv;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)NSArray *cityGroups;

@property (nonatomic,weak)YFCityResultVC *result;
@end

@implementation YFCityVC

-(YFCityResultVC *)result{
    if(!_result){
        YFCityResultVC *resultVC=[[YFCityResultVC alloc] init];
        [self addChildViewController:resultVC];
        self.result=resultVC;
        
        [self.view addSubview:self.result.view];
        [self.result.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.leading.equalTo(@0);
            make.top.equalTo(self.sb.mas_bottom).offset(15);
        }];
        resultVC.onchange=self.onchange;
    }
    return _result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.title=@"切换城市";
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat pad=15;
    UISearchBar *sb=[[UISearchBar alloc] init];
   
    sb.placeholder=@"请输入城市名或拼音";
    [self.view addSubview:sb];
    [sb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(@(pad));
        make.height.equalTo(@35);
        make.right.equalTo(@(-pad));
    }];
    self.sb=sb;
    sb.delegate=self;
    sb.backgroundImage=img(@"bg_login_textfield");
    
    self.tv=[[UITableView alloc] init];
  
    [self.tv setRowHeight:44];
    self.tv.delegate=self;
    self.tv.dataSource=self;
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sb.mas_bottom).offset(pad);
        make.leading.right.bottom.equalTo(@0);
    }];
    
    self.btn=[[UIButton alloc] init];
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.right.top.bottom.equalTo(self.tv);
    }];
    [self.btn setBackgroundColor:[UIColor blackColor]];
    self.btn.alpha=0;
    
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(onBtnClicked:) img:img(@"btn_navigation_close") hlimg:img(@"btn_navigation_close_hl")];
    self.tv.sectionIndexColor=[UIColor blackColor];
    self.cityGroups=[YFMetaTool cityGroups];
    self.sb.tintColor=iColor(32,191,179, 1);
}

-(void)onBtnClicked:(id)sender{
    if(self.btn==sender){
        [self.sb resignFirstResponder];
    }else{
        [self dismissViewControllerAnimated:YES completion:0];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [searchBar setBackgroundImage:img(@"bg_login_textfield_hl")];
    [searchBar setShowsCancelButton:YES animated:YES];
    [UIView animateWithDuration:.5 animations:^{
        self.btn.alpha=.5;
    }];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [searchBar setBackgroundImage:img(@"bg_login_textfield")];
    [searchBar setShowsCancelButton:NO animated:YES];
    [UIView animateWithDuration:.5 animations:^{
        self.btn.alpha=0;
    }];
    self.result.view.hidden=YES;
    searchBar.text=0;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length){
        self.result.view.hidden=NO;
        self.result.searchText=searchText;
    }else{
        self.result.view.hidden=YES;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YFCityGroup *group= self.cityGroups[section];
    return group.cities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"citycelliden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    YFCityGroup *group=self.cityGroups[indexPath.section];
    cell.textLabel.text=group.cities[indexPath.row];
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [(YFCityGroup *)self.cityGroups[section] title];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.cityGroups valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    YFCityGroup *group=self.cityGroups[indexPath.section];
    if(self.onchange)
        self.onchange(group.cities[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:0];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [super dismissViewControllerAnimated:flag completion:completion];

}







@end
