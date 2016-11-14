//
//  YFBanner.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBanner.h"
#import "YFBannerCell.h"
#import "YFChannel.h"
#import "YFNewFLO.h"

static NSString *const celliden=@"bannercelliden";
@interface YFBanner ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@end

@implementation YFBanner


-(void)initUI{
    [iNotiCenter addObserver:self selector:@selector(newPageChange:) name:@"newpagechange" object:0];
}

-(void)newPageChange:(NSNotification *)noti{
    NSIndexPath *idx= noti.userInfo[@"idx"];
    NSIndexPath *former=[self indexPathsForSelectedItems][0];
    
     [self selectItemAtIndexPath:idx animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    [(YFBannerCell *)[self cellForItemAtIndexPath:idx] refresh];
    [(YFBannerCell *)[self cellForItemAtIndexPath:former] refresh];
    

}

-(void)dealloc{
    [iNotiCenter removeObserver:self];
}
-(instancetype)initWithFrame:(CGRect)frame {
    YFNewFLO *flo=[YFNewFLO loWithClz:[self class]];
    if(self=[super initWithFrame:frame collectionViewLayout:flo]){
        [self setShowsHorizontalScrollIndicator:NO];
        [self registerClass:[YFBannerCell class] forCellWithReuseIdentifier:celliden];
        self.delegate=self;
        self.dataSource=self;
        [self initUI];
    }
    return self;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YFBannerCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    [cell refresh];
    if([self onChange]){
        self.onChange(indexPath.item);
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    YFBannerCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    [cell refresh];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFBannerCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    [cell setChannel:self.datas[indexPath.row]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YFChannel *channel = self.datas[indexPath.item];
    
    return  [channel.tname boundingRectWithSize:(CGSize){iScreenW,40} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:0 ].size;

    
}


-(void)appendDatas:(NSMutableArray *)datas{
    for(NSDictionary *dict in datas){
        [self.datas addObject:[YFChannel setDict:dict]];
    }
    [self reloadData];
    [self selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
 
    
}






iLazy4Ary(datas, _datas)
@end
