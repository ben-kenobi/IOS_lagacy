//
//  YFFlagAdapter.m
//  day11-ui-order
//
//  Created by apple on 15/9/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFFlagAdapter.h"
#import "UIView+EXtension.h"

#define ROWH 60

@interface YFFlagAdapter ()
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,weak)UIPickerView *pv;

@end

@implementation YFFlagAdapter

+(instancetype)adapWithPv:(UIPickerView *)pv andDatas:(NSArray *)datas{
    return [[self alloc] initWithPv:pv andDatas:datas];
}

-(instancetype)initWithPv:(UIPickerView *)pv andDatas:(NSArray *)datas{
    if(self=[super init]){
        self.datas=datas;
        pv.delegate=self;
        pv.dataSource=self;
        self.pv=pv;
     
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datas.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return ROWH;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    return [UIView viewWithView:view andFlagDict:_datas[row] frame:(CGRect){0,0,_pv.frame.size.width,ROWH}];
}


@end
