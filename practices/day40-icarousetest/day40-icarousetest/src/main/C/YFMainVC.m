
//
//  YFMainVC.m
//  day40-icarousetest
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFMainVC.h"
#import "iCarousel.h"
#import "UIImageView+WebCache.h"

@interface YFMainVC ()<iCarouselDataSource,iCarouselDelegate>
@property (nonatomic,strong)iCarousel *icv;
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation YFMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor randomColor]];
    self.icv=[[iCarousel alloc] initWithFrame:(CGRect){0,100,self.view.w,self.view.h-200}];
    self.icv.dataSource=self;
    self.icv.delegate=self;
    [self.view addSubview:self.icv];
    [self loadDatas];
}


-(void)loadDatas{
    [IUtil get:iURL(@"http://localhost/resources/vedios.json") cache:0 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        [self.datas addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:0]];
        [self.icv reloadData];
    }];
    [self.icv setType:iCarouselTypeCustom-5];

}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.datas.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if(!view){
        view =[[UIImageView alloc] initWithFrame:self.icv.bounds];
    }
    [(UIImageView *)view sd_setImageWithURL:iURL(self.datas[index][@"image"]) placeholderImage:0 options:0 progress:0 completed:0];
    return view;
}


- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if(!view){
        view=[[UILabel alloc] initWithFrame:(CGRect){0,0,100,100}];
        [view setBackgroundColor:[UIColor randomColor]];
    }
    return view;
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value *1;
        }
        case iCarouselOptionFadeMax:
        {
          return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    static int i=0;
//    [self.icv setType:(i++%(iCarouselTypeCustom+1))];

    


}
iLazy4Ary(datas, _datas)
- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld selected",index);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
      NSLog(@"change");
}
@end
