//
//  ViewController.m
//  10-瀑布流
//
//  Created by apple on 15/4/29.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "WaterfallLayout.h"
#import "WaterfallImageCell.h"
#import "WaterfallFooterView.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *shops;
@property (weak, nonatomic) IBOutlet WaterfallLayout *layout;

// 页脚视图
@property (nonatomic, weak) WaterfallFooterView *footerView;
// 正在加载标记
@property (nonatomic, assign, getter=isLoading) BOOL loading;

// 当前的数据索引
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self loadData];
}

/// 加载数据
- (void)loadData {
    [self.shops addObjectsFromArray:[Shop shopsWithIndex:self.index]];
    
    self.index++;
    
    // 设置布局的属性
    self.layout.columnCount = 3;
    self.layout.dataList = self.shops;
    
    // 刷新数据
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    WaterfallImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

/**
 参数
 kind：类型 
 页头 UICollectionElementKindSectionHeader
 页脚 UICollectionElementKindSectionFooter
 
 Supplementary 追加视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 判断是否是页脚
    if (kind == UICollectionElementKindSectionFooter) {
        self.footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        return self.footerView;
    }
    
    return nil;
}

// 只要滚动视图滚动，就会执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.footerView == nil || self.isLoading) {
        return;
    }
    
    if ((scrollView.contentOffset.y + scrollView.bounds.size.height) > self.footerView.frame.origin.y) {
        NSLog(@"开始刷新");
        // 如果正在刷新数据，不需要再次刷新
        self.loading = YES;
        [self.footerView.indicator startAnimating];
        
        // 模拟数据刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            // 释放掉 footerView
            self.footerView = nil;
            
            [self loadData];
            self.loading = NO;
        });
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)shops {
    if (_shops == nil) {
        _shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

@end
