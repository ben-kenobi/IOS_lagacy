//
//  HMSV.h
//  HMTest01
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSV : UIScrollView
@property (nonatomic,assign)NSInteger count;
-(instancetype)initWithCellCount:(NSInteger)count;
-(void)addView;
@end
