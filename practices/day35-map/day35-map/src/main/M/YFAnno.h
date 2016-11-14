//
//  YFAnno.h
//  day35-map
//
//  Created by apple on 15/11/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class YFAnno02;
@interface YFAnno : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)YFAnno02 *ano02;
@property (nonatomic,assign)BOOL showdetail;
@end
