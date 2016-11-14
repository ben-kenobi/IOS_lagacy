//
//  WaterfallLayout.m
//  10-瀑布流
//
//  Created by apple on 15/4/29.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "WaterfallLayout.h"
#import "Shop.h"

@interface WaterfallLayout()
// 所有 item 的属性数组
@property (nonatomic, strong) NSArray *layoutAttributes;
@end

@implementation WaterfallLayout

/// 准备布局，当 collectionView 的布局发生变化时，会被调用
/// 通常是做布局的准备工作，itemSize,....
/// 准备布局的时候，dataList 已经有值
/// UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的！
- (void)prepareLayout {
    // 1. item 的宽度，根据列数，每个列的宽度是固定
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat itemWidth = (contentWidth - (self.columnCount - 1) * self.minimumInteritemSpacing) / self.columnCount;
    
    // 2. 计算布局属性
    [self attributes:itemWidth];
}

/// 计算布局属性
- (void)attributes:(CGFloat)itemWidth {
    
    // 定义一个列高的数组，记录每一列最大的高度
    CGFloat colHeight[self.columnCount];
    for (int i = 0; i < self.columnCount; ++i) {
        colHeight[i] = self.sectionInset.top;
    }
    
    // 定义总item高
    CGFloat totoalItemHeight = 0;
    
    // 遍历 dataList 数组计算相关的属性
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.dataList.count];
    
    NSInteger index = 0;
    for (Shop *shop in self.dataList) {
        
        // 1> 建立布局属性
        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        
        // 2> 计算当前列数
        NSInteger col = index % self.columnCount;
        
        // 3> 设置frame
        // X
        CGFloat x = self.sectionInset.left + col * (itemWidth + self.minimumInteritemSpacing);
        // Y
        CGFloat y = colHeight[col];
        // height
        CGFloat h = [self itemHeightWith:CGSizeMake(shop.w, shop.h) itemWidth:itemWidth];
        totoalItemHeight += h;
        
        attr.frame = CGRectMake(x, y, itemWidth, h);
        
        // 4> 累加列高
        colHeight[col] += h + self.minimumLineSpacing;
        
        index++;
        
        [arrayM addObject:attr];
    }
    
    // 设置 itemSize，使用总高度的平均值
    self.itemSize = CGSizeMake(itemWidth, totoalItemHeight / self.dataList.count);
    
    // 给属性数组设置数值
    self.layoutAttributes = arrayM.copy;
}

- (CGFloat)itemHeightWith:(CGSize)size itemWidth:(CGFloat)itemWidth {
    return size.height * itemWidth / size.width;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 直接返回计算完成的 属性数组
    return self.layoutAttributes;
}

/// 返回 collectionView 所有 item 属性的数组
/**
 1. 跟踪效果：当到达要显示的区域时，会计算所有显示 item 的属性
 2. 一旦计算完成，所有的属性会被缓存，不会再次计算！
 
 结论：如果提前计算出所有 item 的frame，建立一个数组，在此方法中直接返回。
 应该能够达到瀑布流的效果！
 */
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    
//    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
//    NSLog(@"%@", array);
//    [arrayM enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attr, NSUInteger idx, BOOL *stop) {
//        attr.frame = CGRectMake(0, 0, 200, 100);
//    }];
//    
//    return arrayM.copy;
//}

@end
