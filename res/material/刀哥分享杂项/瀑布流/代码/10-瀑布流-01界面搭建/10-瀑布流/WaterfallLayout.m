//
//  WaterfallLayout.m
//  10-瀑布流
//
//  Created by apple on 15/4/29.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "WaterfallLayout.h"

@implementation WaterfallLayout

/// 准备布局，当 collectionView 的布局发生变化时，会被调用
/// 通常是做布局的准备工作，itemSize,....
- (void)prepareLayout {
    NSLog(@"%s", __FUNCTION__);
    
    self.itemSize = CGSizeMake(100, 120);
}

/// 返回 collectionView 所有 item 属性的数组
/**
 1. 跟踪效果：当到达要显示的区域时，会计算所有显示 item 的属性
 2. 一旦计算完成，所有的属性会被缓存，不会再次计算！
 
 结论：如果提前计算出所有 item 的frame，建立一个数组，在此方法中直接返回。
 应该能够达到瀑布流的效果！
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    NSLog(@"%@", array);
    [arrayM enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attr, NSUInteger idx, BOOL *stop) {
        attr.frame = CGRectMake(0, 0, 200, 100);
    }];
    
    return arrayM.copy;
}

@end
