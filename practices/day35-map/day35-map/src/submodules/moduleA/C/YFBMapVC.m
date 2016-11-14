//
//  YFBMapVC.m
//  day35-map
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBMapVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface YFBMapVC ()<BMKMapViewDelegate,BMKPoiSearchDelegate>
@property (nonatomic,weak)BMKMapView *mv;
@property (nonatomic,strong)BMKPoiSearch *ps;
@end

@implementation YFBMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView *mk=[[BMKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mk];
    self.mv=mk;

    self.ps=[[BMKPoiSearch alloc]init];
    [_mv setZoomLevel:13];
    [_mv setIsSelectedAnnotationViewFront:YES];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mv viewWillAppear];
    _mv.delegate=self;
    _ps.delegate=self;
    
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"北京";
    citySearchOption.keyword =@"美食";
    BOOL flag = [_ps poiSearchInCity:citySearchOption];
    if(flag)
    {

        NSLog(@"城市内检索发送成功");
    }
    else
    {

        NSLog(@"城市内检索发送失败");
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [_mv viewWillDisappear];
    _mv.delegate=nil;
    _ps.delegate=nil;
}

-(void)dealloc{
    _ps=nil;
    _mv=nil;
}


#pragma mark -
#pragma mark BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}



#pragma mark -
#pragma mark BMKSearchDeleage

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mv.annotations];
    [_mv removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mv addAnnotations:annotations];
        [_mv showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}








@end
