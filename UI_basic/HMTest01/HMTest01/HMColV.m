//
//  HMColV.m
//  HMTest01
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMColV.h"
#import "HMColCell.h"
#import "YFCate.h"

@interface HMColV ()

@property (nonatomic,assign)NSInteger rowNum;
@property (nonatomic,weak)UIButton *btn;
@property (nonatomic,assign)CGPoint pre;


@end


@implementation HMColV



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _rowNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMColCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"celliden" forIndexPath:indexPath];
    [cell setStr:[NSString stringWithFormat:@"%ld", indexPath.row]];
    [cell setBackgroundColor:[UIColor randomColor]];
    
    if(!cell.gestureRecognizers.count){
        UILongPressGestureRecognizer *lp=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lp:)];
        [cell addGestureRecognizer:lp];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lp:)];
        [cell addGestureRecognizer:tap];
    }
    
    return cell;
}


-(void)lp:(id)sender{

    if([sender isKindOfClass:[UITapGestureRecognizer class]]){
        [self deleteItemAt:[self.collectionView indexPathForCell:[sender view]]];
    }else {
         UILongPressGestureRecognizer *lp=sender;
        NSInteger state=lp.state;
        if(state==1){
            self.pre=[lp locationInView:self.collectionView];
            UIView *view=[sender view];
            [self.collectionView bringSubviewToFront:view];
            view.transform=CGAffineTransformMakeScale(1.5, 1.5);
            view.alpha=.7;

        }else if(state==2){
            CGPoint p= [lp locationInView:self.collectionView];
            lp.view.transform=CGAffineTransformTranslate(lp.view.transform, (p.x-_pre.x)/1.5, (p.y-_pre.y)/1.5);
            self.pre=p;
            
            for(int i=0;i<_rowNum;i++){
                UIView *view=[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
                if(view!=lp.view&&CGRectContainsPoint(view.frame, p)){
                   NSIndexPath *path=[self.collectionView indexPathForCell:lp.view];
                    NSIndexPath *path2=[NSIndexPath indexPathForRow:i inSection:0];
                    [self.collectionView moveItemAtIndexPath:path toIndexPath:path2];
                    
                    NSInteger from=path.row,to=path2.row,forward=from<to?1:-1;
                    NSString *str=[(HMColCell *)lp.view str];
                    NSInteger j;
                    for(j=to;j!=from;j-=forward){
                        HMColCell* cell1=[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
                        HMColCell* cell2=[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j-forward inSection:0]];
                        cell1.str=cell2.str;
                    }
                    HMColCell* cell1=[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
                    cell1.str=str;
                    
                    break;
                }
            }
            
        }else if(state==3){
            [UIView animateWithDuration:.2 animations:^{
                lp.view.transform=CGAffineTransformIdentity;
                lp.view.alpha=1;
            }];
        }
    }
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btn=[[UIButton alloc] init];
    [self.view addSubview:btn];
    self.btn=btn;
    [self.btn setBackgroundColor:[UIColor redColor]];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.top.equalTo(@30);
    }];
    [btn setTitle:@"add" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerClass:[HMColCell class] forCellWithReuseIdentifier:@"celliden"];
    self.rowNum=9;
    self.collectionView.y=70;
    self.collectionView.h-=120;

    
}
-(void)onBtnClicked:(id)sender{
    self.rowNum++;
    [self.collectionView reloadData];
}

-(void)deleteItemAt:(NSIndexPath *)indexpath{
    self.rowNum--;
    for(NSInteger i=self.rowNum;i>indexpath.row;i--){
        HMColCell *cell1=(HMColCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        HMColCell *cell2=(HMColCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i-1 inSection:0]];
        cell1.str=cell2.str;

    }
    [self.collectionView deleteItemsAtIndexPaths:@[indexpath]];
}






-(void)layoutNormal:(NSMutableArray *)ary idx:(NSInteger)idx{
    for(NSInteger i=self.rowNum;i>idx;i--){
        HMColCell *cell1=ary[i];
        HMColCell *cell2=ary[i-1];
        cell1.str=cell2.str;
    }
    
    [ary removeObjectAtIndex:idx];
    

}
-(void)layoutAnima:(NSArray *)ary idx:(NSInteger)idx{
    [UIView animateWithDuration:.3 animations:^{
        [self layoutNormal:ary idx:idx];
    }];
    dispatch_after(dispatch_time(0, 1e9*.3), dispatch_get_main_queue(), ^{
         [self.collectionView reloadData];
    });
   
    
}


-(instancetype)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:(CGSize){80,80}];
    [layout setMinimumInteritemSpacing:20];
    [layout setMinimumLineSpacing:20];
    [layout setSectionInset:(UIEdgeInsets){20,20,20,20}];
  return [super initWithCollectionViewLayout:layout];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
