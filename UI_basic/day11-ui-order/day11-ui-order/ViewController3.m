//
//  ViewController3.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController3.h"
#import "Masonry.h"

#define ROWH 60

@interface ViewController3 ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak)UIPickerView *pv;
@property (nonatomic,strong)NSArray *datas;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datas.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return nil;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if(!view){
  
        CGFloat wid=self.pv.frame.size.width;
        view=[[UIView alloc] initWithFrame:(CGRect){0,0,wid,ROWH}];
      
        UILabel *lab=[[UILabel alloc] init];
        [view addSubview:lab];
        
        UIImageView *iv=[[UIImageView alloc] init];
        [view addSubview:iv];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(view).offset(30);
            make.width.equalTo(@100);
            make.topMargin.equalTo(@0);
            make.height.equalTo(@ROWH);
        }];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.rightMargin.equalTo(@-20);
            make.width.equalTo(@100);
            make.topMargin.equalTo(@0 );
            make.height.equalTo(@ROWH);
            
        }];

        
        
    }
    
    UIImageView *iv=view.subviews[1];
    UILabel *lab=view.subviews[0];
    lab.text=self.datas[row][@"name"];
    iv.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:self.datas[row][@"icon"] ofType:nil]];
    return view;
  
}




-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return ROWH;
}
-(void)initUI{
    UIPickerView *pv=[[UIPickerView alloc] init];
    self.pv=pv;
    [self.view addSubview:pv];
    pv.delegate=self;
    pv.dataSource=self;
  
    [pv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        
    }];
}

-(NSArray *)datas{
    if(nil==_datas){
        self.datas=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil]];
    }
    return _datas;
}


@end
