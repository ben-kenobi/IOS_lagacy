//
//  ViewController2ViewController.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController2ViewController.h"
#import "Masonry.h"

@interface ViewController2ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak)UIPickerView *pv;
@property (nonatomic,weak)UILabel *city;
@property (nonatomic,weak)UILabel *area;
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,assign)NSInteger currow;

@end

@implementation ViewController2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initState];
}


-(void)initState{
    _currow=0;
    [self pickerView:self.pv didSelectRow:0 inComponent:0];
    [self pickerView:self.pv didSelectRow:0 inComponent:1];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return component?[self.datas[_currow][@"cities"] count]:_datas.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   
    return component?( _datas[_currow][@"cities"][row]):(self.datas[row][@"name"]);
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component){
        _area.text=self.datas[_currow][@"cities"][row];
    }else{
        _currow=row;
        [self.pv reloadComponent:1];
        _city.text=self.datas[row][@"name"];
        _area.text=self.datas[_currow][@"cities"][0];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}


-(void)initUI{
    UIPickerView *pv=[[UIPickerView alloc] init];
    [self.view addSubview:pv];
    self.pv=pv;
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    pv.delegate=self;pv.dataSource=self;
    
    UILabel *(^createLab)(UIView *)=^(UIView *supV){
        UILabel *lab=[[UILabel alloc] init];
        [supV addSubview:lab];
        [lab setBackgroundColor:[UIColor redColor]];
        return lab;
    };
    self.city=createLab(self.view);
    self.area=createLab(self.view);
    
    [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pv.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
        
    }];
    
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pv.mas_bottom).offset(10);
        make.right.equalTo(@0);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];

}

-(NSArray *)datas{
    if(!_datas){
        _datas=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil]];
    }
    return _datas;
}

@end
