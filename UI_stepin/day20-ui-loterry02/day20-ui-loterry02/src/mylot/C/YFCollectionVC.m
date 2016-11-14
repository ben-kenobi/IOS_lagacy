//
//  YFCollectionVC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCollectionVC.h"
#import "YFColCell.h"



@interface YFCollectionVC ()
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation YFCollectionVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.collectionView setBackgroundColor:[UIColor whiteColor] ];
    [self.collectionView registerClass:[YFColCell class] forCellWithReuseIdentifier:celliden];

}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFColCell *cell=[YFColCell cellWith:collectionView path:indexPath dict:_datas[indexPath.row]];
    
    return cell;
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"more_project.json" ofType:nil]] options:NSJSONReadingMutableContainers error:nil]];
	
    }
    return _datas;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.datas[indexPath.row];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",dict[@"customUrl"],dict[@"id"]]];
    NSURL *url3=[NSURL URLWithString:@"file:///"];
    NSURL *url2=[NSURL URLWithString:dict[@"url"]];
   BOOL b= [iApp canOpenURL:url3];
    BOOL b2=[iApp canOpenURL:url2];
    [iApp openURL:url3];
}

-(instancetype)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    
    [layout setSectionInset:(UIEdgeInsets){20,10,20,10}];
    [layout setItemSize:(CGSize){80,80}];
//    [layout setMinimumInteritemSpacing:30];
    [layout setMinimumLineSpacing:20];
    return [super initWithCollectionViewLayout:layout];
}
@end
