

//
//  YFMapVC.m
//  day30-tuangou
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMapVC.h"
#import <MapKit/MapKit.h>
#import "UIBarButtonItem+Ex.h"
#import "YFTopItem.h"
#import "YFCatePopVC.h"
#import "YFCategory.h"
#import "YFDealAnno.h"
#import "DPAPI.h"
#import "TFDeal.h"
#import "MJExtension.h"
#import "YFMetaTool.h"
#import "YFBusiness.h"

@interface YFMapVC ()<MKMapViewDelegate>
@property (nonatomic,weak)UIBarButtonItem *cate;
@property (nonatomic,weak)UIBarButtonItem *back;
@property (nonatomic,strong)MKMapView *map;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,copy)NSString *curcate;
@property (nonatomic,strong)CLGeocoder *coder;
@end

@implementation YFMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(CLGeocoder *)coder{
    if(!_coder){
        self.coder=[[CLGeocoder alloc] init];
    }
    return _coder;
}
-(void)initUI{
    
     self.title=@"地图";
    UIBarButtonItem *back=[UIBarButtonItem itemWithTarget:self action:@selector(onItemClicked:) img:img(@"icon_back") hlimg:img(@"icon_back_highlighted")];
    self.back=back;
    
    YFTopItem *cate=[[YFTopItem alloc] init];
    [cate setOnClick:^(id sender) {
        [self onItemClicked:self.cate];
    }];
    
    UIBarButtonItem *cateitem=[[UIBarButtonItem alloc] initWithCustomView:cate];
    self.navigationItem.leftBarButtonItems=@[back,cateitem];
    self.cate=cateitem;
    
    self.map=[[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.delegate=self;
//    [self.map setMapType:MKMapTypeStandard];
    [self.view addSubview:self.map];
//    [self.map setMultipleTouchEnabled:YES];
      [self.map setUserTrackingMode:MKUserTrackingModeFollow];
    
    self.btn=[[UIButton alloc] init];
    [_btn setBackgroundImage:img(@"icon_map_location") forState:UIControlStateNormal];
    [self.view addSubview:_btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@20);
        make.bottom.equalTo(@-20);
        make.height.width.equalTo(@70);
    }];

  
}

-(void)onItemClicked:(id)sender{
    if(sender==self.cate){
        YFCatePopVC *vc=[[YFCatePopVC alloc] init];
       UIPopoverController*pop=[[UIPopoverController alloc] initWithContentViewController:vc];
        [pop presentPopoverFromBarButtonItem:self.cate permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [vc setOnchange:^(YFCategory *cate, NSInteger subrow) {
            [pop dismissPopoverAnimated:YES];
            YFTopItem *item=(YFTopItem *)self.cate.customView;
            [item.btn setImage:img(cate.icon) forState:UIControlStateNormal];
            [item.btn setImage:img(cate.highlighted_icon) forState:UIControlStateHighlighted];
            item.title.text=cate.name;
            if(!cate.subcategories.count||[cate.subcategories[subrow] isEqualToString:@"全部"]){
                self.curcate=cate.name;
                item.subtitle.text=@"";
            }else{
                self.curcate=cate.subcategories[subrow];
                item.subtitle.text=self.curcate;
            }
            if([self.curcate isEqualToString:@"全部分类"]){
                self.curcate = nil;
            }
            
            [self.map removeAnnotations:self.map.annotations];
            [self mapView:self.map regionDidChangeAnimated:YES];
            
        }];
        
    }else if(sender==self.back.customView){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - MKMapViewDelegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(.25,.25));
    [mapView setRegion:region animated:YES];
    
    [self.coder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error || placemarks.count==0)return ;
        CLPlacemark *pm=[placemarks firstObject];
        NSString *city=pm.locality?pm.locality :pm.addressDictionary[@"State"];
        self.city=[city substringFromIndex:city.length-1];
        [self mapView:self.map regionDidChangeAnimated:YES];
    }];
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    if(!self.city) return;
    
    [self loadDatas ];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(YFDealAnno *)annotation{
    if(![annotation isKindOfClass:[YFDealAnno class]]) return nil;
    static NSString *iden=@"dealiden";
    MKAnnotationView *anno=[mapView dequeueReusableAnnotationViewWithIdentifier:iden];
    if(!anno){
        anno=[[MKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:iden];
        anno.canShowCallout=YES;
    }
    
    anno.annotation=annotation;
    anno.image=img(annotation.icon);
       
    return anno;
    
    
}


-(void)loadDatas{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.city;
    if (self.curcate) {
        params[@"category"] = self.curcate;
    }
    params[@"latitude"] = @(self.map.region.center.latitude);
    params[@"longitude"] = @(self.map.region.center.longitude);
    params[@"radius"] = @(5000);
    
      NSString* urlString = [DPRequest serializeURL:@"http://api.dianping.com/v1/deal/find_deals" params:params];
    [IUtil get:iURL(urlString) cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data&&!error){
            id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            NSArray *deals=[TFDeal objectArrayWithKeyValuesArray:result[@"deals"]];
            for(TFDeal *deal in deals){
                YFCategory *cate=[YFMetaTool categoryWithDeal:deal];
                for(YFBusiness *bus in deal.businesses){
                    YFDealAnno *anno=[[YFDealAnno alloc] init];
                    anno.coordinate=CLLocationCoordinate2DMake(bus.latitude, bus.longitude);
                    anno.title=bus.name;
                    anno.subtitle=deal.title;
                    anno.icon=cate.map_icon;
                    if([self.map.annotations containsObject:anno])break;
                    [self.map addAnnotation:anno];
                }
                
            }
        }else{
            ICommonLog(error);
            ICommonLog2(error);
        }
    }];
}






@end
