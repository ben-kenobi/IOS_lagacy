//
//  YFMapVC03.m
//  day35-map
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMapVC03.h"
#import <MapKit/MapKit.h>
#import "YFEmojiAta.h"
@interface YFMapVC03 ()<MKMapViewDelegate>
@property (nonatomic,weak)MKMapView *mv;
@property (nonatomic,strong)CLGeocoder *coder;
@property (nonatomic,weak)UILabel *lab;
@property (nonatomic,strong)NSRegularExpression *re;

@end

@implementation YFMapVC03

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor randomColor]];
    MKMapView *mv=[[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mv];
    self.mv=mv;
    mv.delegate=self;
    
    [self initUI3];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
}



//rich text
-(void)initUI3{
    UILabel *lab=[[UILabel alloc] initWithFrame:(CGRect){0,0,self.view.w,100}];
    [self.view addSubview:lab];
    self.lab=lab;
    [lab setNumberOfLines:0];
    [lab setBackgroundColor:[UIColor randomColor]];
    
     self.re=[NSRegularExpression regularExpressionWithPattern:@"/category_[0-9]" options:0 error:0];
    
    
    NSString *str=@"qwrlkqjea/category_100123s01/category_123lkjqiowq/category_3qklwdjklqw12/category_212312312dasdasdasdasfwefwefwefewew";
//    NSArray *ary=[self.re matchesInString:str options:NSMatchingReportCompletion range:(NSRange){0,str.length}];
    
    NSMutableAttributedString *mastr=[[NSMutableAttributedString alloc] initWithString:str];
    [self emojistr:mastr re:self.re];
    
    
//    for(NSInteger i=ary.count-1;i>=0;i--){
//        NSTextCheckingResult *res=ary[i];
//         NSTextAttachment *ata= [[YFEmojiAta alloc] init];
//        ata.image=img(([str substringWithRange:(NSRange){res.range.location+1,res.range.length-1}])) ;
//        
//        [mastr replaceCharactersInRange:res.range withAttributedString:[NSAttributedString attributedStringWithAttachment:ata]];
//        
//    }

    [lab setAttributedText:mastr];
   
}
-(void)emojistr:(NSMutableAttributedString *)mastr re:(NSRegularExpression *)re{
    NSString *str=mastr.string;
    NSTextCheckingResult *res=[re firstMatchInString:str options:NSMatchingReportCompletion range:(NSRange){0,str.length}];
    if(res){
        
        NSTextAttachment *ata= [[YFEmojiAta alloc] init];
        ata.image=img(([str substringWithRange:(NSRange){res.range.location+1,res.range.length-1}])) ;
        [mastr replaceCharactersInRange:res.range withAttributedString:[NSAttributedString attributedStringWithAttachment:ata                                             ]];
        [self emojistr:mastr re:re];
    }
    
}



//route line
-(void)initUI2{
   MKDirectionsRequest *req= [[MKDirectionsRequest alloc]init];

    req.source=[[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:(CLLocationCoordinate2D){116,33} addressDictionary:0]];
    req.destination=[[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:(CLLocationCoordinate2D){115,44} addressDictionary:0]];

    [[[MKDirections alloc] initWithRequest:req] calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        for(MKRoute *r in response.routes){
            [self.mv addOverlay: r.polyline];
        }
    }];
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay{
    MKPolyline *pl=overlay;
    MKPolylineRenderer *render=[[MKPolylineRenderer alloc] initWithPolyline:pl];
    [render setLineWidth:1];
    [render setStrokeColor:[UIColor redColor]];
    return render;
}

//navigation
-(void)initUI{
    
    MKMapItem *item1=[MKMapItem mapItemForCurrentLocation];
    MKMapItem *item2=[[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:(CLLocationCoordinate2D){115,36} addressDictionary:@{}]];

    [MKMapItem openMapsWithItems:@[item1,item2] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:@YES}];

    
}
-(CLGeocoder *)coder{
    if(!_coder){
        _coder=[[CLGeocoder alloc] init];
    }
    return _coder;
}

@end
