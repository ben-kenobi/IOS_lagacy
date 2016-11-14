//
//  YFCommonCV.h
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCommonCV : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray *datas;

-(void)appendDatas:(NSArray *)datas;
@property (nonatomic,copy)void (^onChange)(NSIndexPath *);

@end
