//
//  YFIndicator.m
//  day30-newwork02
//
//  Created by apple on 15/11/10.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFIndicator.h"

static CGFloat defA=.3;
static CGFloat defSca=1.3;

@interface YFIndicator ()
@property (nonatomic,strong)NSMutableArray *dots;
@end

@implementation YFIndicator



-(void)setCount:(NSInteger)count{
    _count=count;
    if(!self.dotsize.width)
        self.dotsize=(CGSize){8,8};
    if(!self.tintColor)
        self.tintColor=[UIColor whiteColor];
    if(!self.strokeColor)
        self.strokeColor=[UIColor grayColor];
    [self.dots enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.dots removeAllObjects];
    CGFloat pad=7;
    for(NSInteger i=0;i<count;i++){
        
        UIView *v=[[UIView alloc] initWithFrame:(CGRect){i*(_dotsize.width+pad),0,_dotsize}];
        [v setBackgroundColor:_tintColor];
        [self addSubview:v];
        [self.dots addObject:v];
        v.layer.cornerRadius=_dotsize.width*.5;
        v.layer.masksToBounds=YES;
        v.layer.borderColor=[_strokeColor CGColor];
        v.layer.borderWidth=.3;
        v.layer.opacity=defA;
    }
    CGPoint p=self.center;
    self.frame=(CGRect){0,0,CGRectGetMaxX([[self.dots lastObject] frame]),_dotsize.height};
    self.center=p;
    
    UIView *view= self.dots.firstObject;
    view.alpha=1;
    view.transform=CGAffineTransformMakeScale(defSca, defSca);

}


-(NSMutableArray *)dots{
    if(!_dots){
        _dots=[NSMutableArray array];
    }
    return _dots;
}
-(void)onchange:(CGFloat)f{
    if(!self.dots.count) return;
    NSInteger idx=(NSInteger)f,count=self.dots.count;
    f=f-idx;
    if(idx>0){
        UIView *prev=self.dots[(idx-1)%count];
        prev.transform=CGAffineTransformIdentity;
        prev.alpha=defA;
    }
    UIView *from=self.dots[idx%count];
    UIView *to=self.dots[(idx+1)%count];

   
    from.transform=CGAffineTransformMakeScale(defSca-(defSca-1)*f, defSca-(defSca-1)*f);
    to.transform=CGAffineTransformMakeScale(1+f*(defSca-1), 1+f*(defSca-1));
    from.alpha=1-(1-defA)*f;
    to.alpha=defA+(1-defA)*f;
    
}






@end
