//
//  YFDealsVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDealsVC.h"
#import "MJRefresh.h"
#import "DPAPI.h"
#import "UIView+AutoLayout.h"
#import "MJExtension.h"
#import "UIView+Extension.h"
#import "MBProgressHUD+MJ.h"
#import "YFDealCell.h"
#import "TFDeal.h"
#import "DPRequest.h"
#import "YFDetailVC.h"



@interface YFDealsVC ()<DPRequestDelegate>
@property (nonatomic,strong)NSMutableArray *deals;
@property (nonatomic,weak)UIImageView *defV;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) int totalCount;
@end
static  NSString * const celliden=@"dealcelliden";

@implementation YFDealsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=iGlobalBG;
    [self.collectionView registerClass:[YFDealCell class] forCellWithReuseIdentifier:celliden];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMore:)];
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNew:)];
//    [self loadDatas];
}

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(305, 305);
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
  
    int cols = (size.width == 1024) ? 3 : 2;
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
   
    layout.minimumLineSpacing = inset;
}



-(void)loadDatas{

    NSMutableDictionary *params = [self param];
    params[@"limit"] = @30;
    params[@"page"] = @(self.currentPage+1);
    NSString* urlString = [DPRequest serializeURL:@"http://api.dianping.com/v1/deal/find_deals" params:params];

    [IUtil get:iURL(urlString) cache:1  callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error&&data){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            if([[dict[@"status"] uppercaseString] isEqualToString:@"ERROR"]){
                [MBProgressHUD showError:@"请求数据失败" toView:self.view];
                
            }else{
                self.currentPage++;
                self.totalCount = [dict[@"total_count"] intValue];
                NSArray *newDeals = [TFDeal objectArrayWithKeyValuesArray:dict[@"deals"]];
                if (self.currentPage == 1) {
                    [self.deals removeAllObjects];
                }
                [self.deals addObjectsFromArray:newDeals];
                
                
                [self.collectionView reloadData];
                
            }
        }else{
            [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
            
        }
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }];
   
   
}




-(void)loadNew:(id)sender{
    self.currentPage=0;
    [self loadDatas];
}
-(void)loadMore:(id)sender{
    [self loadDatas];
}



#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    [self viewWillTransitionToSize:CGSizeMake(collectionView.width, 0) withTransitionCoordinator:nil];
    self.collectionView.footerHidden = (self.totalCount == self.deals.count);
    self.defV.hidden = self.deals.count;
    return self.deals.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YFDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YFDetailVC *vc = [[YFDetailVC alloc] init];
    vc.deal = self.deals[indexPath.item];
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)test{
    YFDetailVC *vc = [[YFDetailVC alloc] init];
    
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:vc animated:YES completion:nil];
}

-(UIImageView *)defV{
    if(!_defV){
        UIImageView *defv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        [self.view addSubview:defv];
        [defv autoCenterInSuperview];
        self.defV = defv;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)];
        [defv setGestureRecognizers:@[tap]];
        [defv setUserInteractionEnabled:YES];
    }
    return _defV;
}

iLazy4Ary(deals, _deals)
@end
