//
//  YFMainCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainCon.h"
#import "YFNavCon.h"
#import "YFTabBar.h"


@interface YFMainCon ()

@property (nonatomic,strong)NSMutableArray *cons;
@property (nonatomic,strong)UIViewController *settingVC;
@end

@implementation YFMainCon

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self setViewControllers:self.cons];
    
    YFTabBar *tb=[[YFTabBar alloc] init];
    tb.frame=self.tabBar.bounds;
    [self.tabBar addSubview:tb];
    [tb setOnTabChange:^(NSInteger idx) {
        [self setSelectedIndex:idx];
    }];

    
}

-(NSMutableArray *)cons{
    if(!_cons){
        _cons=[NSMutableArray array];
        NSArray *ary=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cons" ofType:@"plist"]];
        for(NSDictionary *dict in ary){
            id obj=[[NSClassFromString(dict[@"clz"]) alloc] init];
            SEL sel=NSSelectorFromString(@"setPname:");
            if(dict[@"pname"]&&[obj respondsToSelector:sel]){
                [obj performSelector:sel withObject:dict[@"pname"] ];
            }
            
            if([obj isKindOfClass:NSClassFromString(@"YFMylotVC")]){
                UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:@selector(help:)];
                [obj navigationItem].rightBarButtonItem=item;
                self.settingVC=obj;
            }
            
            YFNavCon *nc= [[YFNavCon alloc] initWithRootViewController:obj];
            nc.title=dict[@"title"];
            [_cons addObject:nc];
        }
    }
    return _cons;
}


-(void)help:(id)sender{
    [self.settingVC.navigationController showViewController:[[NSClassFromString(@"YFHelpVC") alloc] init] sender:nil];
}



@end
