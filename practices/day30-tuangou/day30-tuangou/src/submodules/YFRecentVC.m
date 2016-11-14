//
//  YFRecentVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFRecentVC.h"
#import "UIBarButtonItem+Ex.h"

@interface YFRecentVC ()

@end
static NSString *const iden=@"celliden";
@implementation YFRecentVC



-(instancetype)init{
    UICollectionViewFlowLayout *lo=[[UICollectionViewFlowLayout alloc] init];
    lo.itemSize=(CGSize){305,305};
    [lo setSectionInset:(UIEdgeInsets){50,50,50,50}];
    [lo setMinimumLineSpacing:50];
    
    return [self initWithCollectionViewLayout:lo];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:iden];

    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self.navigationController action:@selector(popViewControllerAnimated:) img:img(@"icon_back") hlimg:img(@"icon_back_highlighted")];;

}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    cell.backgroundColor=[UIColor randomColor];
    return cell;
}

@end
