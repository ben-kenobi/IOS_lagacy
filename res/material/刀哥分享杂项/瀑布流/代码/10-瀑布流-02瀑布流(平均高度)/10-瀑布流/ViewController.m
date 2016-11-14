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

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *shops;
@property (weak, nonatomic) IBOutlet WaterfallLayout *layout;

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
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        return footerView;
    }
    
    return nil;
}

#pragma mark - 懒加载
- (NSMutableArray *)shops {
    if (_shops == nil) {
        _shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

@end
