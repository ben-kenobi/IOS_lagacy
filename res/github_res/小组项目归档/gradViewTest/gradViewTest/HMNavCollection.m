//
//  HMNavCollection.m
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import "HMNavCollection.h"
#import "HMNavCollectionCell.h"
#define kIdentifier @"HMNavCollectionCell"
#import "HMCollectionViewModel.h"

@interface HMNavCollection ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>



@end

@implementation HMNavCollection

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{

    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1]; 
    
    self.dataSource = self;
    self.delegate = self;
    
    self.showsHorizontalScrollIndicator = NO;
    
    [self registerClass:[HMNavCollectionCell class] forCellWithReuseIdentifier:kIdentifier];
    
    [self scrollToItemAtIndexPath:self.cuttentIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    return self;

}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.NavDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HMNavCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    
    
    HMCollectionViewModel *model = self.NavDatas[indexPath.item];
    
    cell.name = model.name;
    
    return cell;
    
    
}


-(void)setCuttentIndex:(NSIndexPath *)cuttentIndex{
    
    _cuttentIndex = cuttentIndex;
    
//    [self selectItemAtIndexPath:cuttentIndex animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

}

#pragma UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"collectionScrollToIndex" object:indexPath];

    
    if (self.Myblock) {
        
        self.Myblock();
    }


    
}


#pragma UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    HMCollectionViewModel *model = self.NavDatas[indexPath.item];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = model.name;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    
    return label.bounds.size;
}


@end
