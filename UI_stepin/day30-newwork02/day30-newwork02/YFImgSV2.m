//
//  YFImgSV2.m
//  day30-newwork02
//
//  Created by apple on 15/11/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFImgSV2.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"



static NSString *const iden=@"celliden";
static NSInteger const count=1000;

@interface YFImgSV2 ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation YFImgSV2
@synthesize datas=_datas;
-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    [layout setSectionInset:(UIEdgeInsets){0,0,0,0}];
    [layout setItemSize:frame.size];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    if(self=[super initWithFrame:frame collectionViewLayout:layout]){
        self.delegate=self;
        self.dataSource=self;
        self.pagingEnabled=YES;
        [self setShowsHorizontalScrollIndicator:NO];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:iden];
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static CGFloat maxx=M_PI_4/3;
    CGFloat f= scrollView.contentOffset.x/scrollView.bounds.size.width;
    NSInteger idx=(NSInteger)f;
    f=(f-idx);
    CGFloat f1=f*2>1?1:f*2;
    CGFloat f2=(1-f)*2>1?1:(1-f)*2;
    NSIndexPath *cur= [NSIndexPath indexPathForItem:idx inSection:0];
    NSIndexPath *next=[NSIndexPath indexPathForItem:idx+1 inSection:0];
    UICollectionViewCell *curc=[self cellForItemAtIndexPath:cur];
    UICollectionViewCell *nextc=[self cellForItemAtIndexPath:next];
    
    UIImageView *curiv=curc.contentView.subviews[0];
    UIImageView *nextiv=nextc.contentView.subviews[0];
    NSLog(@"%.2f",f);
    curiv.layer.transform=CATransform3DMakeRotation(-maxx*f1, 0, 0, 1);
    curiv.layer.transform=CATransform3DRotate(curiv.layer.transform,-maxx*4*f1, 0, 1, 0);
    nextiv.layer.transform=CATransform3DMakeRotation(maxx*f2, 0,0 ,1);

    nextiv.layer.transform=CATransform3DRotate(nextiv.layer.transform,maxx*4*f2, 0,1 ,0);
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]];
    [cell setBackgroundColor:[UIColor clearColor]];
    UIImageView *iv=[cell.contentView.subviews firstObject];
    if(!iv){
        iv=[[UIImageView alloc] init];
        [cell.contentView addSubview:iv];
        iv.layer.anchorPoint=(CGPoint){.5,.5};
      CGSize size=  cell.frame.size;
        iv.frame=(CGRect){size.width*.2,size.height*.2,size.width*.6,size.height*.6};
        
//        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(cell).multipliedBy(.85);
//            make.leading.equalTo(cell.mas_right).multipliedBy(.15);
//            make.height.width.equalTo(cell).multipliedBy(.7);
//        }];
    }
    if(self.datas.count){
        NSDictionary *dict=self.datas[indexPath.row%self.datas.count];
        [iv sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
    }
    
    return cell;
}


-(void)appendDatas:(NSArray *)ary{
    [self.datas addObjectsFromArray:ary];
    [self reloadData];
    
}

-(void)setDatas:(NSMutableArray *)datas{
    _datas=datas;
    [self reloadData];
   
}
-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
    }
    return _datas;
}
@end
