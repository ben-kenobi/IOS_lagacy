//
//  YFNewsV.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewsV.h"
#import "YFNewFLO.h"
#import "YFNewsCell.h"
#import "YFChannel.h"

static NSString *const celliden=@"newscelliden";
@interface YFNewsV ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation YFNewsV
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;  {
    NSLog(@"-------");
    int idx=(int)(scrollView.contentOffset.x/scrollView.w);
    [iNotiCenter postNotificationName:@"newpagechange" object:self userInfo:@{@"idx":[NSIndexPath indexPathForItem:idx inSection:0]}];
}


-(void)initUI{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self=[super initWithFrame:frame collectionViewLayout:[YFNewFLO loWithClz:[YFNewsV class]]]){
        self.delegate=self;
        self.dataSource=self;
        [self registerClass:[YFNewsCell class] forCellWithReuseIdentifier:celliden];
        [self setPagingEnabled:YES];
        [self setBounces:NO];
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YFNewsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    [cell setChan:_datas[indexPath.item]];
    return cell;
}

-(void)appendDatas:(NSArray *)ary{
    for(NSDictionary *dict in ary){
        [self.datas addObject:[YFChannel setDict:dict]];
    }
    [self reloadData];
}


iLazy4Ary(datas, _datas)

@end
