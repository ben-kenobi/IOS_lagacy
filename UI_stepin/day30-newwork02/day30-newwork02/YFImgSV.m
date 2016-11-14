//
//  YFImgSV.m
//  day30-newwork02
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFImgSV.h"
#import "UIImageView+WebCache.h"

static NSString *const iden=@"celliden";
static NSInteger const count=2000;

@interface YFImgSV ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,assign)NSInteger idx;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation YFImgSV
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

-(void)beginTimer{
    [self.timer invalidate];
    self.timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(doTimer:) userInfo:0 repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)doTimer:(id)sender{
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_idx inSection:0] atScrollPosition:0 animated:YES];
    if(++_idx>=count)
        _idx=0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.onchange)
        self.onchange(scrollView.contentOffset.x/scrollView.bounds.size.width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _idx=scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self beginTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer=0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]];
    UIImageView *iv=[cell.contentView.subviews firstObject];
    if(!iv){
        iv=[[UIImageView alloc] initWithFrame:cell.bounds];
        [cell.contentView addSubview:iv];
    }
    if(self.datas.count){
        NSDictionary *dict=self.datas[indexPath.row%self.datas.count];
        [iv sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
    }
    
    return cell;
}


-(void)appendDatas:(NSArray *)ary{
    [self.datas addObjectsFromArray:ary];
    self.idx=count*.5/self.datas.count*self.datas.count;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_idx inSection:0] atScrollPosition:0 animated:NO];
    
    [self reloadData];
    [self beginTimer];
}

-(void)setDatas:(NSMutableArray *)datas{
    _datas=datas;
    [self reloadData];
    [self beginTimer];
}
-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
    }
    return _datas;
}
@end
