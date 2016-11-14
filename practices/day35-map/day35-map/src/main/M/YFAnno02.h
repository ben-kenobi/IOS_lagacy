//
//  YFAnno02.h
//  day35-map
//
//  Created by apple on 15/11/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface YFAnno02 : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@property (nonatomic, copy) NSString *title;

@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *icon;

@end
