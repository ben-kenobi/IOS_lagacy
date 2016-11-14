//
//  YFRegionPop.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFRegionPop.h"
#import "YFRegion.h"
#import "YFHomePop.h"
#import "YFCityVC.h"
#import "YFNavVC.h"


@interface YFRegionPop ()<YFHomePopDS>

@end

@implementation YFRegionPop

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    YFHomePop *pop=[[YFHomePop alloc] initWithFrame:(CGRect){0,0,400,409}];
    UIView *v=[[UIView alloc] initWithFrame:(CGRect){0,0,pop.w,44}];
    [self.view addSubview:v];
    UIButton *btn=[[UIButton alloc] initWithFrame:v.bounds];
    [v addSubview:btn];
    [btn setTitle:@"切换城市" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:img(@"btn_changeCity") forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setContentEdgeInsets:(UIEdgeInsets){0,20,0,0}];
    [btn setTitleEdgeInsets:(UIEdgeInsets){0,20,0,0}];
    
    [btn addTarget:self action:@selector(cityChange) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *iv=[[UIImageView alloc] initWithImage:img(@"icon_cell_rightArrow")];
    [v addSubview:iv];
    iv.cy=v.icy;
    iv.r=v.r-20;
    
    
    pop.y=v.h;
    pop.delegate=self;
    [self.view addSubview:pop];
    self.preferredContentSize=(CGSize){pop.w,pop.b};
    
    
}
-(void)cityChange{
    [self.pop dismissPopoverAnimated:YES];
    YFCityVC *vc=[[YFCityVC alloc] init];
    vc.onchange=self.onCityChange;
  YFNavVC *nav=  [[YFNavVC alloc] initWithRootViewController:vc];
    [nav setModalPresentationStyle:UIModalPresentationFormSheet];
    [iApp.keyWindow.rootViewController presentViewController:nav animated:YES completion:0];

}

- (NSInteger)numberOfRows:(YFHomePop *)pop{
    return self.regions.count;
}

- (void)pop:(YFHomePop *)pop updateCell:(UITableViewCell *)cell atRow:(NSInteger)row{
    YFRegion *reg=self.regions[row];
    cell.textLabel.text=reg.name;
    if(reg.subregions.count){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
}

- (NSArray *)pop:(YFHomePop *)pop subdataForRow:(NSInteger)row{
   return [(YFRegion *)self.regions[row] subregions];
}


- (void)pop:(YFHomePop *)pop didSelectRow:(NSInteger)row{
   YFRegion *reg= self.regions[row];
    if(!reg.subregions.count){
        self.onchange(reg,0);
    }
}
- (void)pop:(YFHomePop *)pop didSelectSubRow:(NSInteger)subrow row:(NSInteger)row{
    YFRegion *reg= self.regions[row];

    self.onchange(reg,subrow);

}


@end
