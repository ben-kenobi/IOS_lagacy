//
//  YFNestedCarouselVC.m
//  day40-icarousetest
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFNestedCarouselVC.h"
#import "iCarousel.h"
@interface YFNestedCarouselVC ()<iCarouselDelegate,iCarouselDataSource>
@property (nonatomic,strong)iCarousel *icv;
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation YFNestedCarouselVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _icv=[[iCarousel alloc] initWithFrame:(CGRect){0,100,self.view.w,self.view.h-200}];
    _icv.delegate=self;
    _icv.dataSource=self;
    _icv.type=iCarouselTypeLinear;
    _icv.centerItemWhenSelected=NO;
    [self.view addSubview:_icv];
    
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    if(carousel==_icv){
        return 5;
    }
    return 10;
    
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if(carousel==_icv){
        iCarousel *cv=(iCarousel *)view;
        if(!cv){
            cv=[[iCarousel alloc] initWithFrame:(CGRect){0,0,110,self.view.h-200}];
            cv.dataSource=self;cv.delegate=self;
            cv.vertical=YES;
            cv.type=iCarouselTypeCylinder;
            cv.pagingEnabled=NO;
            view=cv;
            
        }
        cv.tag=index;
        cv.scrollOffset=0;
    }else{
        if(!view){
            UILabel *lab=[[UILabel alloc] initWithFrame:(CGRect){0,0,100,100}];
            [lab  setBackgroundColor:[UIColor randomColor]];
            [lab setTextColor:[UIColor whiteColor]];
            [lab setFont:iBFont(30)];
            view =lab;
        }
        [(UILabel *)view setText:iFormatStr(@"%ld",index)];
        
    }
    return view;
    
    
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    if(carousel==_icv){
        return 110;
    }
    return 110;
}

-(void)carouselDidScroll:(iCarousel *)carousel{
    if(carousel==_icv){

    }else{
//        carousel.scrollOffset=carousel.scrollOffset;
    }
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionShowBackfaces:
        {
            //depths sorting doesn't really work for
            //nested carousels, so it looks pretty odd
            //if you change this to YES
            return YES;
        }
        case iCarouselOptionVisibleItems:
        {
            //the standard visible items calculation
            //cuts off the carousel a bit early if the
            //inner views are also 3D - here we increase
            //the visible item count a bit
            if(carousel==_icv){
                return value+2;
            }
            return value;
        }
        case iCarouselOptionCount:
        {
            if (carousel != _icv)
            {
                //precisely control the carousel
                //size for the inner carousels
                return 15;
            }
            return value;
        }
        case iCarouselOptionWrap:{
            return YES;
        }
        case iCarouselOptionSpacing:{
            return value*1.05;
        }
        default:
        {
            return value;
        }
    }
}

@end
