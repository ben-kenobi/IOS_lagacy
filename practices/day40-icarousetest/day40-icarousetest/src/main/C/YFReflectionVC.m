
//
//  YFReflectionVC.m
//  day40-icarousetest
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFReflectionVC.h"
#import "ReflectionView.h"
#import "iCarousel.h"
#import "UIImageView+WebCache.h"

@interface YFReflectionVC ()<iCarouselDataSource,iCarouselDelegate>
@property (nonatomic,strong)iCarousel *icv;
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation YFReflectionVC

- (void)viewDidLoad {
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
    [self.icv setType:iCarouselTypeCylinder];
    
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.datas.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UILabel *label=nil;
    UIImageView *iv;
    if(!view){
        view=[[ReflectionView alloc] initWithFrame:(CGRect){0,0,200,200}];
        iv =[[UIImageView alloc] initWithFrame:view.bounds];
        [view addSubview:iv];
        iv.tag=2;
        [(ReflectionView *)view setReflectionGap:0];
        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor lightGrayColor];
//        label.layer.borderColor = [UIColor whiteColor].CGColor;
//        label.layer.borderWidth = 4.0f;
//        label.layer.cornerRadius = 8.0f;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag=1;
        [view addSubview:label];
    }else{
        label= [view viewWithTag:1];
        iv=[view viewWithTag:2];
    }
    label.text=iFormatStr(@"%zd",index);
    [iv sd_setImageWithURL:iURL(self.datas[index][@"image"]) placeholderImage:0 options:0 progress:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [(ReflectionView *)view update];
    }];
    [(ReflectionView *)view update];
    return view;
    
    
}





iLazy4Ary(datas, _datas)

@end
