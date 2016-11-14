//
//  YFBanner.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBanner.h"
#import "YFBannerCell.h"
#import "YFChannel.h"

static NSString *const celliden=@"bannercelliden";

@interface YFBanner ()<UICollectionViewDelegateFlowLayout>

@end

@implementation YFBanner

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *lo=[[UICollectionViewFlowLayout alloc] init];
    [lo setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [lo setSectionInset:(UIEdgeInsets){0,10,0,10}];
    if(self=[super initWithFrame:frame collectionViewLayout:lo]){
        self.delegate=self;
        self.dataSource=self;
        [self registerClass:[YFBannerCell class] forCellWithReuseIdentifier:celliden];
        [self setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}
-(void)scrollToIdx:(NSIndexPath *)idx{
    
    NSIndexPath *former=[self indexPathsForSelectedItems][0];
    [self reloadData];
    [self selectItemAtIndexPath:idx animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
   
//    YFBannerCell *cell1=[self cellForItemAtIndexPath:former];
//    YFBannerCell *cell2=[self cellForItemAtIndexPath:idx];
//    [cell1 refresh],[cell2 refresh];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [(YFBannerCell *)[self cellForItemAtIndexPath:indexPath] refresh];
    [self selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    if(self.onChange){
        self.onChange(indexPath);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
     [(YFBannerCell *)[self cellForItemAtIndexPath:indexPath] refresh];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str= [self.datas[indexPath.item] tname];
    return [str boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:0].size;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFBannerCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    [cell setChan:self.datas[indexPath.item]];
    return cell;
}
-(void)appendDatas:(NSArray *)ary{
    for(NSDictionary *dict in ary){
        [self.datas addObject:[YFChannel setDict:dict]];
    }
    [self reloadData];
    NSArray *idxes=[self indexPathsForSelectedItems];
    NSIndexPath *path;
    if(!idxes||!idxes.count)
        path=[NSIndexPath indexPathForItem:0 inSection:0];
    else
        path=idxes[0];
    [self selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}



@end
