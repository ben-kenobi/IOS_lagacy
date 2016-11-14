//
//  YFTabbarVC.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTabbarVC.h"

@interface YFTabbarVC ()
@property (nonatomic,strong)NSArray *datas;

@end

@implementation YFTabbarVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    Class navVC=NSClassFromString(iRes4dict(@"conf.plist")[@"navVC"]);
    for(int i=0;i<self.datas.count;i++){
        [self addChildViewController:[self navVCByDict:_datas[i] clz:navVC]];
    }
}
-(UIViewController *)navVCByDict:(NSDictionary *)dict clz:(Class)clz{
    UIViewController *vc= [NSClassFromString(dict[@"clz"]).alloc init];
    UINavigationController *nav=[clz.alloc initWithRootViewController:vc];
    vc.title=dict[@"title"];
    nav.tabBarItem.image=img(dict[@"icon"]);
    nav.tabBarItem.selectedImage=img(([NSString stringWithFormat:@"%@_Sel", dict[@"icon"]]));
    return nav;
}

-(NSArray *)datas{
    if(!_datas){
        _datas=iRes4ary(@"mainvcs.plist");
    }
    return _datas;
}

@end
