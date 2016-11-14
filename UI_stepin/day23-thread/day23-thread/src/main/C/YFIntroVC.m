//
//  YFIntroVC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFIntroVC.h"
#import "AppDelegate.h"


static NSString *iden=@"introcelliden";


@interface YFIntroVC ()

@property (nonatomic,weak)UIPageControl *pc;

@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,weak)UIImageView *iv1;
@property (nonatomic,weak)UIImageView *iv2;
@property (nonatomic,weak)UIImageView *iv3;
@property (nonatomic,weak)UIButton *btn;
@end

@implementation YFIntroVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    self.view.backgroundColor=[UIColor randomColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:iden];
    [self.collectionView setBounces:NO];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    self.collectionView.bounds=self.view.bounds;
    
    UIPageControl *pc=[[UIPageControl alloc] init];
    [pc setUserInteractionEnabled:NO];
    [pc setNumberOfPages:self.datas.count];
    [pc setCurrentPage:0];
    [pc setPageIndicatorTintColor:[UIColor randomColor]];
    [pc setCurrentPageIndicatorTintColor:[UIColor randomColor]];
    [self.view addSubview:pc];
    self.pc=pc;
    [pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-20);
        make.centerX.equalTo(@0);
    }];
    UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"] ];
    iv.x=-202;
    [self.collectionView addSubview:iv];
    
    
    [self imgByIdx:0];
    
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
    [btn sizeToFit];
    self.btn=btn;
    [self.collectionView addSubview:btn];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.x=iScreenW*3+(iScreenW-btn.w)*.5;
    btn.y=iScreenH*.9;
}


-(void)onBtnClicked:(id)sender{
    if(self.btn==sender){
        [[iApp keyWindow] setRootViewController:[AppDelegate rootVC:YES]];
    }
}

-(void)imgByIdx:(NSInteger)idx{
    UIImage *img1=[UIImage imageNamed:[NSString stringWithFormat:@"guide%ld",idx+1]];
    UIImage *img2=[UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%ld",idx+1]];
    UIImage *img3=[UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%ld",idx+1]];
    
    if(!self.iv1){
        UIImageView *iv1=[[UIImageView alloc] initWithImage:img1];
        UIImageView *iv2=[[UIImageView alloc] initWithImage:img2];
        UIImageView *iv3=[[UIImageView alloc] initWithImage:img3];
        self.iv1=iv1;
        self.iv2=iv2;
        self.iv3=iv3;
        [self.collectionView addSubview:iv1];
        [self.collectionView addSubview:iv2];
        [self.collectionView addSubview:iv3];
        iv2.y=iScreenH*.7;
        iv3.y=iScreenH*.8;
    }else{
        [self.iv1 setImage:img1];
        [self.iv2 setImage:img2];
        [self.iv3 setImage:img3];
    }
 
    
}

-(instancetype)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:iScreen.bounds.size];
    [layout setScrollDirection:1];
    [layout setMinimumLineSpacing:1];
    return [self initWithCollectionViewLayout:layout];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    cell.layer.contents=(__bridge id)[[UIImage imageNamed:_datas[indexPath.row]]CGImage];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page= scrollView.contentOffset.x/scrollView.w;
    [self.pc setCurrentPage:page];
    CGFloat ofx=  scrollView.contentOffset.x;
    CGFloat x=self.iv1.x>ofx?ofx-iScreenW:ofx+iScreenW;
    self.iv1.x=x;
    self.iv2.x=x;
    self.iv3.x=x;
    
    [self imgByIdx:page];
    
    [UIView animateWithDuration:.25 animations:^{
        self.iv1.x=ofx;
        self.iv2.x=ofx;
        self.iv3.x=ofx;
    }];
    
}

-(NSArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        for(int i=1;i<=4;i++){
            [_datas addObject:[NSString stringWithFormat:@"guide%dBackground568h",i]];
        }
    }
    return _datas;
}

@end
