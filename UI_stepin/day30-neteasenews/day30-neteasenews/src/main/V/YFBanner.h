//
//  YFBanner.h
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFBanner : UICollectionView
@property (nonatomic,strong)NSMutableArray *datas;
-(void)appendDatas:(NSMutableArray *)datas;
@property (nonatomic,copy)void (^onChange)(NSInteger idx);
@end
