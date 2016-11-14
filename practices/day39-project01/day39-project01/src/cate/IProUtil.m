//
//  iProUtil.m
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "IProUtil.h"
#import "MD5.h"

@interface IProUtil ()
@property (nonatomic,strong)CLLocationManager *man;
@property (nonatomic,copy)void (^locationcb)(BOOL,NSArray *);
@end


@implementation IProUtil

+(NSString *)digestAry:(NSArray *)ary{
    NSMutableString *mstr=[NSMutableString string];
    for(NSString *str in ary){
        [mstr appendString:str];
    }
    return [MD5 MD5Encrypt:mstr];
}

+(instancetype)shareInstance{
    static long l=0;
    static IProUtil *instance;
    dispatch_once(&l, ^{
        instance=[[IProUtil alloc] init];
    });
    return instance;
}






#pragma  mark - 
#pragma  mark  CLLocationManagerDelegate
+(void)locationWith:(void (^)(BOOL, NSArray *))cb{
    IProUtil *inst=[self shareInstance];
    inst.locationcb=cb;
    [inst.man startUpdatingLocation];
}

-(CLLocationManager *)man{
    if(!_man){
        _man=[[CLLocationManager alloc] init];
        [_man requestAlwaysAuthorization];
        [_man requestWhenInUseAuthorization];
        _man.delegate=self;
    }
    return _man;
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    [_man stopUpdatingLocation];
    if(self.locationcb){
        self.locationcb(1,locations);
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [_man stopUpdatingLocation];
    if(self.locationcb){
        self.locationcb(0,@[error]);
    }

}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status==kCLAuthorizationStatusDenied){
        [_man stopUpdatingLocation];
    }else{
        [_man startUpdatingLocation];
        
    }
}

@end
