//
//  YFSortVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSortVC.h"
#import "YFSort.h"
#import "YFMetaTool.h"
@interface YFSortButton :UIButton
@property (nonatomic,strong)YFSort *sort;
@end


@interface YFSortVC ()

@end

@implementation YFSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    NSArray *sorts=[YFMetaTool sorts];
    CGFloat w=100,h=30,pad=15,margin=15,height=0,width=pad*2+w;
    YFSortButton *btn;
    for(NSInteger i=0;i<sorts.count;i++){
        btn=[[YFSortButton alloc]initWithFrame:(CGRect){pad,pad+i*(margin+h),w,h}];
        btn.sort=sorts[i];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [self.view addSubview:btn];
    }
    height=CGRectGetMaxY(btn.frame)+pad;
    self.preferredContentSize=(CGSize){width,height};
}

-(void)onBtnClicked:(YFSortButton *)sender{
    if (self.onchange) {
        self.onchange(sender.sort);
    }
}

@end


@implementation YFSortButton

-(instancetype)initWithFrame:(CGRect)frame{

    if(self=[super initWithFrame:frame]){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)setSort:(YFSort *)sort{
    _sort=sort;
    [self setTitle:sort.label forState:UIControlStateNormal];
    
}

@end