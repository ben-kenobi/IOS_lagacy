//
//  YFMapViewVC.m
//  day35-map
//
//  Created by apple on 15/11/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMapViewVC.h"
#import <MapKit/MapKit.h>
#import "YFAnno02.h"
#import "YFAnno.h"
#import "YFAnnoDescV.h"
@interface YFMapViewVC ()<MKMapViewDelegate>
@property (nonatomic,weak)MKMapView *mv;
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation YFMapViewVC

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if([view.annotation isKindOfClass:[YFAnno class]]){
        YFAnno *ano=view.annotation;
        if(ano.showdetail){
            return ;
        }else{
            [mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if([obj isKindOfClass:[YFAnno02 class]]){
                    [mapView removeAnnotation:obj];
                }else if([obj isKindOfClass:[YFAnno class]]){
                    [(YFAnno*)obj setShowdetail:NO];
                }
            }];
            ano.showdetail=YES;
            [mapView addAnnotation:ano.ano02];
        }
    }else if([view.annotation isKindOfClass:[YFAnno02 class]]){
        
    }
    
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[YFAnno class]]){
        YFAnno *ano=annotation;
        static NSString *const iden=@"anoiden";
        MKAnnotationView *av=[mapView dequeueReusableAnnotationViewWithIdentifier:iden];
        if(!av){
            av=[[MKAnnotationView alloc] initWithAnnotation:0 reuseIdentifier:iden];
        }
        av.image=img(ano.ano02.icon);
        return av;
        
    }else if([annotation isKindOfClass:[YFAnno02 class]]){
        YFAnno02 *ano=annotation;
        static NSString *const iden=@"ano02iden";
        YFAnnoDescV *av=(YFAnnoDescV *)[mapView dequeueReusableAnnotationViewWithIdentifier:iden];
        if(!av){
            av=[[YFAnnoDescV alloc] initWithAnnotation:0 reuseIdentifier:iden];
        }
        [av setAnno:ano];
        return av;
    }
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MKMapView *mv=[[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mv];
    self.mv=mv;
    mv.delegate=self;
    for(int i=0;i<self.datas.count;i++){
        YFAnno *ano=[[YFAnno alloc] init];
        YFAnno02 *a02=self.datas[i];
        [ano setCoordinate:a02.coordinate];
        ano.ano02=a02;
        [mv addAnnotation:ano];
    }
}

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


@end
