

//
//  YFFXImageVC.m
//  day40-icarousetest
//
//  Created by apple on 15/11/23.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFFXImageVC.h"
#import "iCarousel.h"
#import "FXImageView.h"
@interface YFFXImageVC ()<iCarouselDelegate,iCarouselDataSource>
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableArray *remoteDatas;
@property (nonatomic,strong)iCarousel *icv;

@end

@implementation YFFXImageVC

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
        FXImageView *imageView=[[FXImageView alloc] initWithFrame:(CGRect){0,0,200,200}];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;
    }
    ((FXImageView *)view).processedImage=img(@"placeholder.png");
    
//     ((FXImageView *)view).image= imgFromF(self.datas[index]);
    [((FXImageView *)view) setImageWithContentsOfURL:iURL(self.remoteDatas[index])];
//    [((FXImageView *)view) setImageWithContentsOfFile:self.datas[index]];
    return view;
}





-(void)loadDatas{
   NSArray *ary= [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@"Lake"];
    
    for(NSString *path in ary){
        [self.datas addObject:(path)];
    }
    
    
    
    NSArray *remoteary= iRes4ary(@"Images.plist");
    
    [self.remoteDatas addObjectsFromArray:remoteary];
    [self.icv reloadData];
}


iLazy4Ary(datas, _datas)

iLazy4Ary(remoteDatas, _remoteDatas)
@end
