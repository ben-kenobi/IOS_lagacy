


//
//  TestVC01V.m
//  day39-testonly
//
//  Created by apple on 15/11/24.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "TestVC01.h"


@interface TestVC01 ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong)UICollectionView *cv;
@end

@implementation TestVC01

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"c" forIndexPath:indexPath ];
    [cell setBackgroundColor:[UIColor randomColor]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){100,100};
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *lo=[[UICollectionViewFlowLayout alloc] init];
    self.cv=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:lo];
    [lo setMinimumInteritemSpacing:0];
    [lo setMinimumLineSpacing:0];
    [lo setSectionInset:(UIEdgeInsets){0,0,10,0}];
    self.cv.delegate=self;
    self.cv.dataSource=self; 
    [self.view addSubview:self.cv];
      [self.cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader    withReuseIdentifier:@"header"];
    [self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"a"];
    [self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"b"];
     [self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"c"];
    [self.cv setBackgroundColor:[UIColor lightGrayColor]];
  
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return (CGSize){self.view.w/4,90};
    }else if(indexPath.section==1){
        return (CGSize){self.view.w/2,90};
    }else {
        return (CGSize){self.view.w,90};
    }
}

@end
