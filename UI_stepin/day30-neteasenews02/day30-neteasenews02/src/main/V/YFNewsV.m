//
//  YFNewsV.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsV.h"
#import "YFNewsCell.h"
#import "YFChannel.h"

static NSString *const celliden=@"newscelliden";

@interface YFNewsV ()

@end

@implementation YFNewsV

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *lo=[[UICollectionViewFlowLayout alloc] init];
    [lo setMinimumLineSpacing:0];
    [lo setMinimumInteritemSpacing:0];
    [lo setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [lo setItemSize:frame.size];
    if(self=[super initWithFrame:frame collectionViewLayout:lo]){
        self.delegate=self;
        self.dataSource=self;
        self.pagingEnabled=YES;
        [self registerClass:[YFNewsCell class] forCellWithReuseIdentifier:celliden];
    }
    return self;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFNewsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    [cell setChan:self.datas[indexPath.item]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int idx=(int)(self.contentOffset.x/self.w);
    if(self.onChange){
        self.onChange([NSIndexPath indexPathForItem:idx inSection:0]);
    }
}

-(void)appendDatas:(NSArray *)datas{
    for(NSDictionary *dict in datas){
        [self.datas addObject:[YFChannel setDict:dict]];
    }
    [self reloadData];
}



@end
