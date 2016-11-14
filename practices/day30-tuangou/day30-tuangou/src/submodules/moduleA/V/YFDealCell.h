//
//  YFDealCell.h
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFDeal;

@interface YFDealCell : UICollectionViewCell

@property (nonatomic,strong)TFDeal *deal;
@property (nonatomic,copy)void (^onCellStateChange)(YFDealCell *cell);

@end
