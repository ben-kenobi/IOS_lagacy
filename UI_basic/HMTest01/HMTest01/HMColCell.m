//
//  HMColCell.m
//  HMTest01
//
//  Created by apple on 15/10/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "HMColCell.h"
#import "YFCate.h"


@interface HMColCell ()

@property (nonatomic,strong)UILabel *lab;

@end

@implementation HMColCell


-(void)setStr:(NSString *)str{
    _str=str;
    self.lab.text=str;
}

-(void)initUI{
    UILabel *lab=[[UILabel alloc] init];
    lab.textColor=[UIColor whiteColor];
    self.backgroundColor=[UIColor redColor];
    self.lab=lab;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

/*
 -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
     UICollectionView *cv=(UICollectionView *)self.superview;
    UITouch *touch=[touches anyObject];
    CGPoint p=[touch locationInView:cv];
    CGPoint pre=[touch previousLocationInView:cv];
    
    self.transform=CGAffineTransformTranslate(self.transform, (p.x-pre.x)/1.5, (p.y-pre.y)/1.5);

    NSInteger count=[cv.dataSource collectionView:cv numberOfItemsInSection:0];
    for(NSInteger i=0;i<count;i++){
        NSIndexPath *path=[NSIndexPath indexPathForRow:i inSection:0];
        HMColCell *cell=[cv cellForItemAtIndexPath:path];
        if(cell!=self&&CGRectContainsPoint(cell.frame ,p)){
             NSIndexPath *path2= [cv indexPathForCell:self];
            [cv moveItemAtIndexPath:path2 toIndexPath:path];
            
            NSInteger row2=path2.row,row1=path.row,forward=1;
            if(row2>row1){
                forward=-1;
            }
            
            NSString *strcur=self.str;
            NSInteger j;
            for( j=row1;j!=row2;j-=forward){
                HMColCell *cell1=(HMColCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
                HMColCell *cell2=(HMColCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j-forward inSection:0]];
                cell1.str=cell2.str;
            }
            HMColCell *cell1=(HMColCell *)[cv cellForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
            
            cell1.str=strcur;
            break;
        }
    }
    
}
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.gestureRecognizers[0] setEnabled:YES];
    [UIView animateWithDuration:.2 animations:^{
        self.transform=CGAffineTransformIdentity;
        self.alpha=1;
    }];
  
}


@end
