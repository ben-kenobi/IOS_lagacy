//
//  YFCityAdap.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCityAdap.h"
@interface YFCityAdap()
@property (nonatomic,weak)UIPickerView *pv;
@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,assign)NSInteger currow;
@property (nonatomic,weak)UILabel *province;
@property (nonatomic,weak)UILabel *city;
@end

@implementation YFCityAdap


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger rows;
    if(component==0){
        rows=self.datas.count;
    }else if(component==1){
        rows=[self.datas[_currow][@"cities"] count];
    }
    return rows;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title;
    if(component==0){
        title=self.datas[row][@"name"];
    }else if(component==1){
        title=self.datas[_currow][@"cities"][row];
    }
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component==0){
        _currow=row;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        self.province.text=_datas[row][@"name"];
        [self pickerView:pickerView didSelectRow:0 inComponent:1];
    }else if(component==1){
        self.city.text=_datas[_currow][@"cities"][row];
    }
}

-(instancetype)initWithPv:(UIPickerView *)pv andDatas:(NSArray *)datas province:(UILabel *)province city:(UILabel *)city{
    if(self=[super init]){
        self.datas=datas;
        self.pv=pv;
        pv.delegate=self;
        pv.dataSource=self;
        self.province=province;
        self.city=city;
        [self pickerView:pv didSelectRow:0 inComponent:0];

    }
    return self;
}
+(instancetype)adapWithPv:(UIPickerView *)pv andDatas:(NSArray *)datas province:(UILabel *)province city:(UILabel *)city{
    return [[self alloc] initWithPv:pv andDatas:datas province:province city:city];
}
@end
