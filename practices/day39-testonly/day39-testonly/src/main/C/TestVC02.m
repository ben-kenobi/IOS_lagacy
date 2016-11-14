


//
//  TestVC02.m
//  day39-testonly
//
//  Created by apple on 15/11/25.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "TestVC02.h"
#import "YFemojiCell.h"
#import "UIImage+GIF.h"

@interface TestVC02 ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *cv;
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation TestVC02

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *lo=[[UICollectionViewFlowLayout alloc] init];
    self.cv=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:lo];
    [lo setMinimumInteritemSpacing:0];
    [lo setMinimumLineSpacing:0];
    [lo setItemSize:(CGSize){self.view.w/7,self.view.w/7}];
    [lo setSectionInset:(UIEdgeInsets){0,0,10,0}];
    self.cv.delegate=self;
    self.cv.dataSource=self;
    [self.cv registerClass:[YFEmojiCell class] forCellWithReuseIdentifier:@"c"];
    [self.cv setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.cv];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    
    NSMutableArray *ary=[NSMutableArray array];
    for(int i=0;i<17;i++){
        [ary addObject:[NSString stringWithFormat:@"emotion%d.gif",i]];
    }
    self.datas=ary;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFEmojiCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"c" forIndexPath:indexPath ];
    [cell setBackgroundColor:[UIColor randomColor]];
    [cell setUrl:self.datas[indexPath.row]];

    
    UIImageView *iv=[[UIImageView alloc] initWithFrame:cell.bounds];
    [cell addSubview:iv];
    iv.image=[UIImage sd_animatedGIFWithData:iData4F(iRes(self.datas[indexPath.row]))];
    
    return cell;
}


@end
