//
//  YFBannerCell.h
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  YFChannel;

@interface YFBannerCell : UICollectionViewCell
@property (nonatomic,weak)UILabel *lab;
@property (nonatomic,strong)YFChannel *channel;
-(void)refresh;
@end
