//
//  YFImgSV2.h
//  day30-newwork02
//
//  Created by apple on 15/11/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFImgSV2 : UICollectionView
@property (nonatomic,strong)NSMutableArray *datas;
-(void)appendDatas:(NSArray *)ary;
@property (nonatomic,copy)void (^onchange)(CGFloat idx);
@end
