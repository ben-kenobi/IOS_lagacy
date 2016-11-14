//
//  YFMoreVC.m
//  day21-ui-lottery03
//
//  Created by apple on 15/10/20.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMoreVC.h"
#import "YFColCell.h"

static NSString *celliden=@"colcelliden";

@interface YFMoreVC ()
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation YFMoreVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.datas[indexPath.row];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",dict[@"customUrl"],dict[@"id"]]];
    if(![iApp canOpenURL:url])
        url=[NSURL URLWithString:dict[@"url"]];
    
    [iApp openURL:url];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datas count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFColCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    [cell setDict:self.datas[indexPath.row]];

    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        [_datas addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:iRes(@"more_project.json")] options:0 error:0]];
    }
    return _datas;
}

-(void)initUI{
    [self.collectionView registerClass:[YFColCell class] forCellWithReuseIdentifier:celliden];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(instancetype)init{
    UICollectionViewFlowLayout *layo=[[UICollectionViewFlowLayout alloc] init];
    [layo setItemSize:(CGSize){80,80}];
    [layo setSectionInset:(UIEdgeInsets){10,10,10,10}];
    return [self initWithCollectionViewLayout:layo];
}
@end





