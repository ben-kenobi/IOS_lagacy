//
//  YFMainCon.m
//  day20-ui-lottery
//
//  Created by apple on 15/10/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainVC.h"
#import "YFNavVC.h"
#import "YFTabBar.h"


@interface YFMainVC ()

@property (nonatomic,strong)NSMutableArray *cons;
@property (nonatomic,weak)YFTabBar *tb;
@end

@implementation YFMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    [self setViewControllers:self.cons];
    
    YFTabBar *tb=[[YFTabBar alloc] init];
    self.tb=tb;
    tb.frame=self.tabBar.bounds;
    [self.tabBar addSubview:tb];
    [tb setOnTabChange:^(NSInteger idx) {
        [self setSelectedIndex:idx];
    }];
    UISwipeGestureRecognizer *swipr=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipr.direction=UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *swipl=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipl.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipr];
    [self.view addGestureRecognizer:swipl];
    
    
}

-(void)swipe:(id)sender{
    if([sender direction]==UISwipeGestureRecognizerDirectionLeft){
        [self setSelectedIndex:self.selectedIndex+1];
    }else if([sender direction]==UISwipeGestureRecognizerDirectionRight){
        [self setSelectedIndex:self.selectedIndex-1];
    }
    [self.tb selectAtIdx:[self selectedIndex]];
}

-(NSMutableArray *)cons{
    if(!_cons){
        _cons=[NSMutableArray array];
        Class nav=NSClassFromString(iRes4dict(@"conf.plist")[@"navVC"]);
        NSArray *ary=iRes4ary(@"mainvcs.plist");
        for(NSDictionary *dict in ary){
            id obj=[[NSClassFromString(dict[@"clz"]) alloc] init];
            SEL sel=NSSelectorFromString(@"setPname:");
            if(dict[@"pname"]&&[obj respondsToSelector:sel]){
                [obj performSelector:sel withObject:dict[@"pname"] ];
            }
            
            UINavigationController * nc= [[nav alloc] initWithRootViewController:obj];
            nc.title=dict[@"title"];
            [_cons addObject:nc];
        }
    }
    return _cons;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}



@end
