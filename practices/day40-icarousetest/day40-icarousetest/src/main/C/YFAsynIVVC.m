//
//  YFAsynIVVC.m
//  day40-icarousetest
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFAsynIVVC.h"
#import "iCarousel.h"
#import "AsyncImageView.h"
@interface YFAsynIVVC ()<iCarouselDelegate,iCarouselDataSource>
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)iCarousel *icv;

@end

@implementation YFAsynIVVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icv=[[iCarousel alloc] initWithFrame:(CGRect){0,100,self.view.w,self.view.h-200}];
    [self.view addSubview:self.icv];
    self.icv.type=iCarouselTypeCoverFlow2;
    self.icv.delegate=self;
    self.icv.dataSource=self;
    
    [self loadDatas];
}



- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.datas.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if(view==nil){
        AsyncImageView *imageView=[[AsyncImageView alloc] initWithFrame:(CGRect){0,0,200,200}];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        view = imageView;
    }
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
    ((AsyncImageView *)view).imageURL=iURL( self.datas[index]);
    return view;
}






-(void)loadDatas{
    NSArray *ary= iRes4ary(@"Images.plist");
    
    [self.datas addObjectsFromArray:ary];
    
    [self.icv reloadData];
}


iLazy4Ary(datas, _datas)

@end
