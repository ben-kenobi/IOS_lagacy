//
//  YFMainVC02.m
//  day35-map
//
//  Created by apple on 15/11/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainVC02.h"
#import <MapKit/MapKit.h>
#import "YFAnno.h"
#import "YFAnno02.h"
#import "YFAnnoDescV.h"
@interface YFMainVC02 ()<MKMapViewDelegate>
@property (nonatomic,weak)MKMapView *mv;
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation YFMainVC02

-(NSMutableArray *)datas{
    if(!_datas){
        _datas=[NSMutableArray array];
        for(int i=0;i<10;i++){
            YFAnno02 *a02=[[YFAnno02 alloc] init];
            [a02 setCoordinate:CLLocationCoordinate2DMake(3+i*5, 3+10*i)];
            a02.image=@"fandian";
            a02.icon=[NSString stringWithFormat:@"category_%d",i%5+1];
            a02.desc=@"12312312312312werwrewerwer3123123123";
            a02.title=@"title";
            [_datas addObject:a02];
        }
       

    }
    return _datas;
}
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
////    NSLog(@"%.2f---%.2f",mapView.centerCoordinate.longitude,mapView.centerCoordinate.latitude);
//    [mapView removeAnnotations:mapView.annotations];
//    for(int i=0;i<self.datas.count;i++){
//        YFAnno02 *a02=_datas[i];
//        YFAnno *ano= [[YFAnno alloc]init];
//        [ano setCoordinate:(CLLocationCoordinate2D){mapView.centerCoordinate.latitude-5+i,mapView.centerCoordinate.longitude-5+i}];
//        ano.ano02=a02;
//        a02.coordinate=ano.coordinate;
//        [mapView addAnnotation:ano];
//    }
//}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    userLocation.title=@"current";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MKMapView *mv=[[MKMapView alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-100}];
    [self.view addSubview:mv];
    self.mv=mv;
//    [mv setUserTrackingMode:MKUserTrackingModeFollow];
    [mv setDelegate:self];
    [mv setMapType:MKMapTypeStandard];
//    [[[CLLocationManager alloc]init] requestAlwaysAuthorization];
    
    
    for(int i=0;i<self.datas.count;i++){
        YFAnno02 *a02=_datas[i];
        YFAnno *ano= [[YFAnno alloc]init];
   
        ano.ano02=a02;
        ano.coordinate=a02.coordinate;
        [mv addAnnotation:ano];
    }
    
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{

    if( [view.annotation isKindOfClass:[YFAnno class]]){
        YFAnno *ano=view.annotation;
        if(ano.showdetail){
            return;
        }else{
            [mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if([obj isKindOfClass:[YFAnno02 class]]){
                    [mapView removeAnnotation:obj];
                }else if([obj isKindOfClass:[YFAnno class]]){
                    [(YFAnno*)obj setShowdetail:NO];
                }
            }];
            
            [ano setShowdetail:YES];
            [mapView addAnnotation:ano.ano02];
        }
    }else if([view.annotation isKindOfClass:[YFAnno02 class]]){
        
    }
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[YFAnno class]]){
        static NSString *const iden=@"annoiden";
        MKAnnotationView *av=[mapView dequeueReusableAnnotationViewWithIdentifier:iden];
        if(!av){
            av=[[MKAnnotationView alloc] initWithAnnotation:0 reuseIdentifier:iden];
        }
        
        YFAnno *ano= (YFAnno *)annotation;
        [av setImage:img(ano.ano02.icon)];
        return av;
    }else if([annotation isKindOfClass:[YFAnno02 class]]){
        static NSString *const iden=@"annodesciden";
        YFAnnoDescV *av=(YFAnnoDescV *)[mapView dequeueReusableAnnotationViewWithIdentifier:iden];
        if(!av){
            av=[[YFAnnoDescV alloc] initWithAnnotation:0 reuseIdentifier:iden];
        }
        
        YFAnno02 *ano= (YFAnno02 *)annotation;
        [av setAnno:ano];
    
        return av;
    }
    return 0;
   
}








@end
