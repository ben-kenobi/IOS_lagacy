//
//  YFFoodAdap.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFoodAdap.h"

@interface YFFoodAdap ()
@property (nonatomic,strong)NSArray *labs;
@property (nonatomic,weak)UIPickerView *pv;
@property (nonatomic,strong)NSArray *datas;


@end

@implementation YFFoodAdap


-(void)randomSelect{
    for(int i=0;i<_datas.count;i++){
        NSInteger ran;
        do{
         ran=arc4random()%[_datas[i] count];
        }while(ran==[self.pv selectedRowInComponent:i]);
        [self.pv selectRow:ran inComponent:i animated:YES];
        [self pickerView:nil didSelectRow:ran inComponent:i];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _datas.count;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_datas[component] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _datas[component][row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *lab=_labs[component];
    lab.text=_datas[component][row];
}

-(instancetype)initWithPv:(UIPickerView *)pv datas:(NSArray *)datas labs:(NSArray *)labs{
    if(self=[super init]){
        self.pv=pv;
        self.datas=datas;
        self.labs=labs;
        pv.delegate=self;
        pv.dataSource=self;
        for(int i=0;i<3;i++){
            [self pickerView:pv didSelectRow:0 inComponent:i];
        }
        
    }
    return self;
}
+(instancetype)adapWithPv:(UIPickerView *)pv datas:(NSArray *)datas labs:(NSArray *)labs{
    return [[self alloc] initWithPv:pv datas:datas labs:labs];
}
@end
