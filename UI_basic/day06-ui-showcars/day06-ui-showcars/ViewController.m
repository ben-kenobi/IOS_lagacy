//
//  ViewController.m
//  day06-ui-showcars
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "YFCarGroup.h"

@interface ViewController ()<UITableViewDataSource>
@property (nonatomic,weak) UITableView *tv;
@property (nonatomic,strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    UITableView *tv=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tv =tv;
    self.tv.dataSource=self;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((YFCarGroup *)self.datas[section]).cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"cariden";
    UITableViewCell *cel=[tableView dequeueReusableCellWithIdentifier:iden];
    if(nil==cel){
        cel=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
   
    YFCarGroup *grou=self.datas[indexPath.section];
    cel.textLabel.text=[grou.cars[indexPath.row] valueForKeyPath:@"name"];
   
    cel.imageView.image=[UIImage imageNamed:[grou.cars[indexPath.row] valueForKeyPath:@"icon"]];
    return cel;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return ((YFCarGroup *)self.datas[section]).title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.datas valueForKeyPath:@"title"];
}

-(NSMutableArray *)datas{
    if(nil==_datas){
        _datas=[NSMutableArray array];
        NSArray *ary = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cars_total" ofType:@"plist"]];
        for(NSDictionary *dict in ary){
            [_datas addObject:[YFCarGroup modWithDict:dict]];
        }
    }
    return _datas;
}

@end
