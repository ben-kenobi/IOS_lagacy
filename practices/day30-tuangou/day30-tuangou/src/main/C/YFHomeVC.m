//
//  YFHomeVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomeVC.h"
#import "YFMetaTool.h"
#import "YFTopItem.h"
#import "UIBarButtonItem+Ex.h"
#import "MBProgressHUD+MJ.h"
#import "YFSort.h"
#import "YFCatePopVC.h"
#import "YFCategory.h"
#import "MJRefresh.h"
#import "YFRegionPop.h"
#import "YFCity.h"
#import "YFRegion.h"
#import "YFSortVC.h"
#import "YFSort.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"
#import "YFMapVC.h"
#import "YFSearchVC.h"
#import "YFRecentVC.h"
#import "YFCollecVC.h"


@interface YFHomeVC ()<AwesomeMenuDelegate>

/** 分类item */
@property (nonatomic, strong) UIBarButtonItem *cate;
/** 地区item */
@property (nonatomic, strong) UIBarButtonItem *region;
/** 排序item */
@property (nonatomic, strong) UIBarButtonItem *sort;
@property (nonatomic, strong) UIBarButtonItem *map;
@property (nonatomic, strong) UIBarButtonItem *search;


@property (nonatomic, copy) NSString *curcity;
/** 当前选中的分类名字 */
@property (nonatomic, copy) NSString *curcate;
/** 当前选中的区域名字 */
@property (nonatomic, copy) NSString *curregion;
/** 当前选中的排序 */
@property (nonatomic, strong) YFSort *cursort;

@property (nonatomic,weak)UIPopoverController *curpop;

@end

@implementation YFHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftNav];
    [self initRightNav];
    [self initAwesomeMenu];
    
}

-(void)initAwesomeMenu{
    AwesomeMenuItem *item=[[AwesomeMenuItem alloc] initWithImage:img(@"icon_pathMenu_background_highlighted") highlightedImage:0 ContentImage:img(@"icon_pathMenu_mainMine_normal") highlightedContentImage:0];
    
    AwesomeMenuItem *item1=[[AwesomeMenuItem alloc] initWithImage:img(@"bg_pathMenu_black_normal") highlightedImage:0 ContentImage:img(@"icon_pathMenu_collect_normal") highlightedContentImage:img(@"icon_pathMenu_collect_highlighted")];
    AwesomeMenuItem *item2=[[AwesomeMenuItem alloc] initWithImage:img(@"bg_pathMenu_black_normal") highlightedImage:0 ContentImage:img(@"icon_pathMenu_collect_normal") highlightedContentImage:img(@"icon_pathMenu_collect_highlighted")];
    AwesomeMenuItem *item3=[[AwesomeMenuItem alloc] initWithImage:img(@"bg_pathMenu_black_normal") highlightedImage:0 ContentImage:img(@"icon_pathMenu_collect_normal") highlightedContentImage:img(@"icon_pathMenu_collect_highlighted")];
    AwesomeMenuItem *item4=[[AwesomeMenuItem alloc] initWithImage:img(@"bg_pathMenu_black_normal") highlightedImage:0 ContentImage:img(@"icon_pathMenu_collect_normal") highlightedContentImage:img(@"icon_pathMenu_collect_highlighted")];
    
    AwesomeMenu *menu=[[AwesomeMenu alloc] initWithFrame:(CGRect){0,0,0,0} startItem:item optionMenus:@[item1,item2,item3,item4]];
    menu.alpha=.5;
    menu.menuWholeAngle=M_PI_2;
    menu.startPoint=(CGPoint){50,150};
    menu.delegate=self;
    menu.rotateAddButton=NO;
    [self.view addSubview:menu];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(@0);
        make.width.height.equalTo(@200);
    }];
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu{
    menu.contentImage=img(@"icon_pathMenu_cross_normal");
    menu.alpha=1;
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu{
    menu.contentImage=img(@"icon_pathMenu_mainMine_normal");
    menu.alpha=.5;
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx{
    menu.alpha=.5;
    menu.contentImage=img(@"icon_pathMenu_mainMine_normal");
    if(idx==0){
     YFCollecVC *vc=[[YFCollecVC alloc] init];
        vc.title=@"收藏";
        [self.navigationController showViewController:vc sender:0];
    }else if(idx==1){
        YFRecentVC *recent=[[YFRecentVC alloc] init];
        recent.title=@"最近访问记录";
        [self.navigationController showViewController:recent sender:0];
    }
}

-(void)initLeftNav{
    UIBarButtonItem *logo=[[UIBarButtonItem alloc] initWithImage:img(@"icon_meituan_logo") style:0 target:0 action:0];
    logo.enabled=NO;
    YFTopItem *catetopitem=[[YFTopItem alloc] init];
    [catetopitem setOnClick:^(id sender) {
        [self onItemClicked:self.cate];
    }];
    
    self.cate=[[UIBarButtonItem alloc] initWithCustomView:catetopitem];
    catetopitem.title.text=@"类别";
    catetopitem.subtitle.text=@"aa";
    YFTopItem *regiontopitem=[[YFTopItem alloc] init];
    [regiontopitem setOnClick:^(id sender) {
         [self onItemClicked:self.region];
    }];
    self.region=[[UIBarButtonItem alloc] initWithCustomView:regiontopitem];
    regiontopitem.title.text=@"区域";
    regiontopitem.subtitle.text=@"bb";
    
    YFTopItem *sorttopitem=[[YFTopItem alloc] init];
    [sorttopitem setOnClick:^(id sender) {
        [self onItemClicked:self.sort];
    }];
    sorttopitem.title.text=@"排序";
    [sorttopitem.btn setImage:img(@"icon_sort") forState:UIControlStateNormal];
    [sorttopitem.btn setImage:img(@"icon_sort_highlighted") forState:UIControlStateHighlighted];
    self.sort=[[UIBarButtonItem alloc] initWithCustomView:sorttopitem];
    self.navigationItem.leftBarButtonItems=@[logo,self.cate,self.region,self.sort];
    
    
    
}
-(void)initRightNav{
    self.map=[UIBarButtonItem itemWithTarget:self action:@selector(onItemClicked:) img:img(@"icon_map") hlimg:img(@"icon_map_highlighted")];
    self.map.customView.w=60;
    
    self.search = [UIBarButtonItem itemWithTarget:self action:@selector(onItemClicked:) img:img(@"icon_search") hlimg:img(@"icon_search_highlighted")];
    _search.customView.w = 60;
    self.navigationItem.rightBarButtonItems = @[_map, _search];
}
-(void)onItemClicked:(id)sender{
    if(sender==self.map.customView){
        YFMapVC *map=[[YFMapVC alloc] init];
        [self.navigationController showViewController:map sender:0];
    }else if(sender==self.search.customView){
        if(self.curcity){
            YFSearchVC *vc=[[YFSearchVC alloc] init];
            vc.city=self.curcity;
            [self.navigationController showViewController:vc sender:0];
        }else{
            [MBProgressHUD showError:@"请先选择城市" toView:self.view];
        }
        
        
        
    }else if(sender==self.cate){
        [self.curpop dismissPopoverAnimated:NO];
        YFCatePopVC *vc=[[YFCatePopVC alloc] init];
        UIPopoverController* catepop=[[UIPopoverController alloc] initWithContentViewController:vc];
        [vc setOnchange:^(YFCategory *cate, NSInteger subrow) {
            YFTopItem *item=(YFTopItem *)self.cate.customView;
            if(cate.subcategories.count){
                self.curcate=cate.subcategories[subrow];
                item.subtitle.text=self.curcate;
            }else{
                self.curcate=cate.name;
                item.subtitle.text=@"";
            }
            if([self.curcate isEqualToString:@"全部分类"]){
                self.curcate=nil;
            }
            
            item.title.text=cate.name;
            [item.btn setImage:img(cate.icon) forState:UIControlStateNormal];
            [item.btn setImage:img(cate.highlighted_icon) forState:UIControlStateNormal];
           
            [catepop dismissPopoverAnimated:YES];
            [self.collectionView headerBeginRefreshing];
            
        }];
        
        [catepop presentPopoverFromBarButtonItem:self.cate permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.curpop=catepop;
        
    }else if(sender==self.region){
        [self.curpop dismissPopoverAnimated:NO];
        YFRegionPop *vc=[[YFRegionPop alloc] init];
        if(self.curcity){
            YFCity *city=[[[YFMetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.curcity]] firstObject ];
            vc.regions=city.regions;
        }
        UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:vc];
        [vc setOnchange:^(YFRegion *reg, NSInteger subrow) {
            YFTopItem *item=(YFTopItem *) self.region.customView;
            if([reg subregions].count==0||[[reg subregions][subrow] isEqualToString:@"全部"]){
                self.curregion=reg.name;
                item.subtitle.text=@"";
            }else{
                self.curregion=[reg subregions][subrow];
                item.subtitle.text=self.curregion;
            }
            if([self.curregion isEqualToString:@"全部"]){
                self.curregion=nil;
            }
            
            
            item.title.text=[NSString stringWithFormat:@"%@ - %@",self.curcity,reg.name];
            [pop dismissPopoverAnimated:YES];
            [self.collectionView headerBeginRefreshing];
            
        }];
        [vc setOnCityChange:^(NSString *name){
            self.curcity=name;
          YFTopItem *item= (YFTopItem *)self.region.customView;
            item.title.text=[NSString stringWithFormat:@"%@ - 全部",self.curcity];
            item.subtitle.text=@"";
            [self.collectionView headerBeginRefreshing];
        }];
        
        [pop presentPopoverFromBarButtonItem:self.region permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        vc.pop=pop;
        self.curpop=pop;
        
    }else if(sender==self.sort){
        [self.curpop dismissPopoverAnimated:NO];
        YFSortVC *vc=[[YFSortVC alloc]init];
       UIPopoverController*  sortpop=[[UIPopoverController alloc] initWithContentViewController:vc];
        [sortpop presentPopoverFromBarButtonItem:self.sort permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [vc setOnchange:^(YFSort *sort) {
            self.cursort=sort;
            YFTopItem *item=(YFTopItem *)self.sort.customView;
            item.subtitle.text=sort.label;
            [sortpop dismissPopoverAnimated:YES];
            [self.collectionView headerBeginRefreshing];
        }];
         self.curpop=sortpop;
    }
    
}

-(NSDictionary *)param{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    if(!self.curcity)
        self.curcity=@"北京";
    params[@"city"] = self.curcity;
    if(self.curcate)
        params[@"category"]=self.curcate;
    if(self.curregion)
        params[@"region"]=self.curregion;
    if(self.cursort)
        params[@"sort"]=@(self.cursort.value);
    return params;
}
@end
