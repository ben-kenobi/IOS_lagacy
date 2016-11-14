//
//  YFMainVC.m
//  day35-map
//
//  Created by apple on 15/11/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMainVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface YFMainVC ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (nonatomic,strong)CLLocationManager *man;
@property (nonatomic,strong)CLGeocoder *coder;
@property (nonatomic,weak)MKMapView *mv;
@end

@implementation YFMainVC
-(CLLocationManager *)man{
    if(!_man){
        _man=[[CLLocationManager alloc] init];
        _man.delegate=self;
        [_man requestAlwaysAuthorization];
        [_man setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        
    }
    return _man;
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    NSLog(@"%@",locations);
    [manager stopUpdatingLocation];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    if([CLLocationManager locationServicesEnabled]){
//        [self.man startUpdatingLocation];
//        NSLog(@"-----");
//    }
    
    
    
    self.coder=[[CLGeocoder alloc] init];
    [_coder geocodeAddressString:@"北京" completionHandler:^(NSArray *placemarks, NSError *error) {
        for(CLPlacemark *pm in placemarks){
            CLLocationCoordinate2D cor= pm.location.coordinate;
            NSLog(@"%.2f-%.2f",cor.longitude,cor.latitude);
            [_coder reverseGeocodeLocation:pm.location completionHandler:^(NSArray *placemarks, NSError *error) {
                for(CLPlacemark *pm in placemarks){
                    NSLog(@"%@",pm.name);
                }
            }];
        }
    }];
}


#pragma mark MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
  CLLocationCoordinate2D loc=  userLocation.location.coordinate;
    NSLog(@"%.2f,%.2f",loc.longitude,loc.latitude);
    
    userLocation.title=@"aaa";
    userLocation.subtitle=@"subtitle";
}




-(void)initUI{
    MKMapView *mv=[[MKMapView alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-100}];
    [self.view addSubview:mv];
    self.mv=mv;
    [mv setMapType:MKMapTypeStandard];
    mv.delegate=self;
    [mv setUserTrackingMode:MKUserTrackingModeFollow];
    [[[CLLocationManager alloc] init] requestAlwaysAuthorization];
//    [mv setShowsUserLocation:YES];

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor randomColor]];
    [self initUI];
    
    CLLocation  *loc1=[[CLLocation alloc] initWithLatitude:36 longitude:110];
    CLLocation  *loc2=[[CLLocation alloc] initWithLatitude:36 longitude:111];
    
  
    double dis= [loc1 distanceFromLocation:loc2];
    NSLog(@"%.2f",dis);
}


@end
