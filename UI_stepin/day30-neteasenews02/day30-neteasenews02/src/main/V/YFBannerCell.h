//
//  YFBannerCell.h
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFChannel;

@interface YFBannerCell : UICollectionViewCell

@property (nonatomic,strong)YFChannel *chan;
-(void)refresh;
@end
