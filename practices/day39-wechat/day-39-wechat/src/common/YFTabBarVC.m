

//
//  YFTabBarVC.m
//  day39-project01
//
//  Created by apple on 15/11/21.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFTabBarVC.h"
#import "YFCusNavVC.h"
#import "YFNavVC.h"

@interface YFTabBarVC ()

@property (nonatomic,strong)NSMutableArray *cons;
@end

@implementation YFTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBottom];
    [self setViewControllers:self.cons];
    self.tabBar.hidden=YES;
}



-(void )initBottom{
    if(!_bottom){
        _bottom=[[UIView alloc] initWithFrame:self.tabBar.frame ];
        CGFloat bw=_bottom.w*.2,bh=_bottom.h;

        for(int i=0;i<5;i++){
            
            UIButton *b=[[NoHlBtn alloc] initWithFrame:(CGRect){i*bw,0,bw,bh}];
            [_bottom addSubview:b];
            b.tag=(i==4?-1:i);
            [b setImage:img(iFormatStr(@"home_%d",i)) forState:UIControlStateNormal];
            [b setImage:img(iFormatStr(@"home_%d_pressed",i)) forState:UIControlStateSelected];
            [b addTarget:self action:@selector(onTabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if(i==0)
                b.selected=YES;
        }
        
        _bottom.backgroundColor=[UIColor lightGrayColor];
        [self.view addSubview:_bottom];
        [self.view addSubview:[self subbotWith:@[@"联系商家",@"摇一摇",@"直播",@"关于"]]];
      
    }
}



-(UIView *)subbotWith:(NSArray *)ary{
    if(!_subbot){
        CGFloat subboth=50;
        self.subbot=[[UIView alloc] initWithFrame:(CGRect){0,self.tabBar.y-subboth,iScreenW,subboth}];
        [self.tabBar addSubview:self.subbot];
        [self.subbot setBackgroundColor:iColor(0, 0, 0, .5)];

        self.subbot.hidden=YES;
        CGFloat wids[4];
        for (int i=0;i<4;i++ ) {
            wids[i]= [ary[i] boundingRectWithSize:(CGSize){CGFLOAT_MAX,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:iFont(18)} context:0].size.width;
        }
        CGFloat gap=(iScreenW-wids[0]-wids[1]-wids[2]-wids[3])/8;
        CGFloat from=0;
        for(int i=0;i<4;i++){
            if(i>0){
                UIView *line=[[UIView alloc] initWithFrame:(CGRect){from,20,1,self.subbot.h-40}];
                [line setBackgroundColor:[UIColor whiteColor]];
                line.alpha=.5;
                [self.subbot addSubview:line];
            }
            
            NoHlBtn *b=[[NoHlBtn alloc] initWithFrame:(CGRect){from,0,wids[i]+gap*2,self.subbot.h}];
            from+=wids[i]+gap*2;
            [b setTitle:ary[i] forState:UIControlStateNormal];
            [self.subbot addSubview:b];
            b.tag=4+i;
            [b addTarget:self action:@selector(onTabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    return _subbot;
}

-(void)onTabBtnClick:(UIButton *)sender{
    NSInteger tag=sender.tag;
    [self.bottom.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setSelected:NO];
    }];
    sender.selected=YES;
    if(tag==-1){
        self.subbot.hidden=NO;
    }else{
        self.subbot.hidden=YES;
        self.selectedIndex=tag;
    }

}


-(NSMutableArray *)cons{
    if(!_cons){
        _cons=[NSMutableArray array];
        NSArray *ary=iRes4ary(@"cons.plist");
        for(NSDictionary *dict in ary){
            id obj=[[NSClassFromString(dict[@"clz"]) alloc] init];
            SEL sel=NSSelectorFromString(@"setPname:");
            if(dict[@"pname"]&&[obj respondsToSelector:sel]){
                [obj performSelector:sel withObject:dict[@"pname"] ];
            }
            
            YFNavVC *nc= [[YFNavVC alloc] initWithRootViewController:obj];
//            nc.title=dict[@"title"];
            [nc setNavigationBarHidden:YES];
            [obj setNavtitleStr: dict[@"title"]];
            [_cons addObject:nc];
        }
    }
    return _cons;
}


@end



@implementation NoHlBtn

-(void)setHighlighted:(BOOL)highlighted{
    
}

@end