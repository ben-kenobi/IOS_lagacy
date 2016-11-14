//
//  YFCollecVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCollecVC.h"
#import "UIBarButtonItem+Ex.h"
#import "YFDealCell.h"
#import "MJRefresh.h"
#import "TFDeal.h"
#import "YFDealTool.h"
#import "YFDetailVC.h"

static NSString *const iden=@"celliden";

@interface YFCollecVC ()
@property (nonatomic,strong)UIBarButtonItem *back;
@property (nonatomic,strong)UIBarButtonItem *selAll;
@property (nonatomic,strong)UIBarButtonItem *unselAll;
@property (nonatomic,strong)UIBarButtonItem *remAll;
@property (nonatomic,strong)UIImageView *defV;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,assign)NSInteger page;


@end

@implementation YFCollecVC


-(instancetype)init{
    UICollectionViewFlowLayout *lo=[[UICollectionViewFlowLayout alloc] init];
    lo.itemSize=(CGSize){305,305};
    [lo setMinimumLineSpacing:50];
    return [self initWithCollectionViewLayout:lo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收藏的团购";
    self.collectionView.backgroundColor=iGlobalBG;
    self.back=[UIBarButtonItem itemWithTarget:self.navigationController action:@selector(popViewControllerAnimated:) img:img(@"icon_back") hlimg:img(@"icon_back_highlighted")];
    self.navigationItem.leftBarButtonItem=self.back;
    [self.collectionView registerClass:[YFDealCell class] forCellWithReuseIdentifier:iden];
    self.collectionView.alwaysBounceVertical=YES;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
    
    [self.collectionView addFooterWithTarget:self action:@selector(loadMore)];
    [self loadMore];
    
}
-(void)edit:(UIBarButtonItem *)item{
    if([item.title isEqualToString:@"编辑"]){
        item.title=@"完成";
        
        if(!self.selAll){
            self.selAll=[[UIBarButtonItem alloc]initWithTitle:@"  全选  " style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
            self.unselAll=[[UIBarButtonItem alloc]initWithTitle:@"  全不选  " style:UIBarButtonItemStyleDone target:self action:@selector(onItemClicked:)];
            self.remAll=[[UIBarButtonItem alloc]initWithTitle:@"  删除  " style:UIBarButtonItemStylePlain target:self action:@selector(onItemClicked:)];
            self.remAll.enabled=NO;
        }
        
        
        self.navigationItem.leftBarButtonItems=@[self.back,self.selAll,self.unselAll,self.remAll];
        for(TFDeal *deal in self.datas){
            deal.editing=YES;
        }
    }else{
        item.title=@"编辑";
        self.navigationItem.leftBarButtonItems=@[self.back];
        for(TFDeal *deal in self.datas){
            deal.editing=NO;
        }
    }
    [self.collectionView reloadData];
}


-(void)onItemClicked:(UIBarButtonItem *)item{
    if(item==self.selAll){
        for(TFDeal *deal in self.datas){
            deal.checking=YES;
        }
        self.remAll.enabled=YES;
    }else if(item==self.unselAll){
        for(TFDeal *deal in self.datas){
            deal.checking=NO;
        }
        self.remAll.enabled=NO;
    }else if(item==self.remAll){
        NSMutableArray *temp=[NSMutableArray array];
        for(TFDeal *deal in self.datas){
            if(deal.isChecking){
                [YFDealTool removeCollectDeal:deal];
                [temp addObject:deal];
            }
            
        }
        [self.datas removeObjectsInArray:temp];
        self.remAll.enabled=NO;
    }
    [self.collectionView reloadData];
}

-(void)loadMore{
    self.page++;
//    [self.datas addObjectsFromArray:[YFDealTool collectDeals:(int)self.page]];
    [self.collectionView reloadData];
    [self.collectionView footerEndRefreshing];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    int cols=(size.width==1024)?3:2;
    UICollectionViewFlowLayout *lo=(UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat pad=(size.width-cols*lo.itemSize.width)/(cols+1);
    lo.sectionInset=(UIEdgeInsets){pad,pad,pad,pad};
}




#pragma mark    UICollectionViewDataSource 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    [self viewWillTransitionToSize:CGSizeMake(collectionView.w, 0) withTransitionCoordinator:0];
//    self.collectionView.footerHidden=(self.datas.count==[YFDealTool collectDealsCount]);
    self.defV.hidden=self.datas.count;
//    return self.datas.count;
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YFDealCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    [cell setOnCellStateChange:^(YFDealCell *cell) {
        BOOL hasCheck=0;
        for(TFDeal *deal in self.datas)
            if((hasCheck=deal.isChecking))
                break;
        self.remAll.enabled=hasCheck;
    }];
//    cell.deal=self.datas[indexPath.item];
    [cell setBackgroundColor:[UIColor randomColor]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YFDetailVC *vc=[[YFDetailVC alloc] init];
    vc.deal=self.datas[indexPath.item];
    [vc setOnCollectChange:^(NSMutableDictionary *mary) {
        if([mary[IsCollected] boolValue]){
            [self.datas insertObject:mary[CollectDeal] atIndex:0];
        }else{
            [self.datas removeObject:mary[CollectDeal]];
        }
        [self.collectionView reloadData];
    }];
    [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:0];
    
}











-(UIImageView *)defV{
    if(!_defV){
        _defV=[[UIImageView alloc] initWithImage:img(@"icon_collects_empty")];
        [self.view addSubview:_defV];
        [_defV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
        }];
    }
    return _defV;
}

iLazy4Ary(datas, _datas)

@end
