//
//  YFIntroVC.m
//  day20-ui-loterry02
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFIntroVC.h"
#import "UIColor+Extension.h"
#import "AppDelegate.h"

#import "YFCate.h"
static NSString *celliden=@"celliden";

@interface YFIntroVC ()

@property (nonatomic,weak)UIPageControl *pc;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,weak)UIImageView *iv1;
@property (nonatomic,weak)UIImageView *iv2;
@property (nonatomic,weak)UIImageView *iv3;
@property (nonatomic,weak)UIButton *btn;

@end

@implementation YFIntroVC
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat ofx=scrollView.contentOffset.x;
    CGFloat w=scrollView.w;
    NSInteger i=(ofx /w);
    
    CGFloat gap=_iv1.x>ofx?-w:w;
    
    _iv1.x=ofx+gap;
    _iv2.x=ofx+gap;
    _iv3.x=ofx+gap;
    
    _iv1.image=[UIImage imageNamed:[NSString stringWithFormat:@"guide%ld" ,i+1]];
    _iv2.image=[UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%ld" ,i+1]];
    _iv3.image=[UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%ld" ,i+1]];
    [UIView animateWithDuration:.5
                     animations:^{
                         _iv1.x=ofx;
                         _iv2.x=ofx;
                         _iv3.x=ofx;
                     }];
  
    [self.pc setCurrentPage:i];
    
}

-(instancetype)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=IScreen.bounds.size;
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:30];
    [layout setScrollDirection:1];
    return [super initWithCollectionViewLayout:layout];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [self.collectionView setBackgroundColor:[UIColor grayColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:celliden];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setBounces:NO];
    UIPageControl *pc=[[UIPageControl alloc ]init];
    [self.view addSubview:pc];
    [pc setCurrentPage:0];
    [pc setPageIndicatorTintColor:[UIColor grayColor] ];
    [pc setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [pc setNumberOfPages:self.datas.count];
    [pc setUserInteractionEnabled:NO];
    [pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-20);
    }];
    self.pc=pc;
    
    
    UIImageView *iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    iv.x=-202;
    [self.collectionView addSubview:iv];
    
    
    UIImageView *iv1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    UIImageView *iv2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    UIImageView *iv3=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    [self.collectionView addSubview:iv1];
    [self.collectionView addSubview:iv2];
    [self.collectionView addSubview:iv3];
    iv2.y=self.collectionView.h*.75;
    iv3.y=self.collectionView.h*.85;
    self.iv1=iv1;
    self.iv2=iv2;
    self.iv3=iv3;
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [self.collectionView addSubview:btn];
    self.btn=btn;
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
   CGFloat sw= IScreen.bounds.size.width;
    CGFloat sh= IScreen.bounds.size.height;
    btn.x=sw*3+  (sw-btn.w)*.5;
    btn.y=sh-20-btn.h;
    

    
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.btn){
        UIApplication *app=[UIApplication sharedApplication];
        [app keyWindow].rootViewController=[[NSClassFromString(@"YFMainCon") alloc] init];
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}



-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray arrayWithObjects:@"guide1Background",@"guide2Background",@"guide3Background",@"guide4Background", nil];
    }
    return _datas;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:celliden forIndexPath:indexPath];
    cell.layer.contents=(__bridge id)[[UIImage imageNamed:self.datas[indexPath.row]] CGImage];
    return cell;
}

@end
