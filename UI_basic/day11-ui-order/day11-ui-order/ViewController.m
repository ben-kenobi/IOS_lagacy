//
//  ViewController.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pv;

@property (nonatomic,strong)NSArray *datas;
@property (weak, nonatomic) IBOutlet UILabel *food;
@property (weak, nonatomic) IBOutlet UILabel *fruit;
@property (weak, nonatomic) IBOutlet UILabel *drink;
@property (strong,nonatomic) NSArray *ary;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [self.datas[component] objectAtIndex:row];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.datas.count;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *ary= self.datas[component];
    return ary.count;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_ary[component] setText:self.datas[component][row]];
}

-(NSArray *)datas{
    if(!_datas){
        self.datas=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"foods.plist" ofType:nil]];
    }
    return _datas;
}
-(void)initUI{
    self.ary=@[_fruit,_food,_drink];
    for(int i=0;i<_datas.count;i++){
        [self pickerView:self.pv didSelectRow:0 inComponent:i];
    }
    [self.btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onBtnClicked:(UIButton *)sender{
    if(sender==self.btn){
        for(int i=0;i<_datas.count;i++){
            NSInteger currow=[self.pv selectedRowInComponent:i];
            NSInteger newrow;
            do{
                newrow=arc4random()%[_datas[i] count];
            }while(newrow==currow);
            [self.pv selectRow:newrow inComponent:i animated:YES];

            [self pickerView:self.pv didSelectRow:newrow inComponent:i];
        }
    }
}









@end
