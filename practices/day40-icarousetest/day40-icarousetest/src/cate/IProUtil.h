//
//  iProUtil.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface IProUtil : NSObject<CLLocationManagerDelegate>

+(void)locationWith:(void(^)(BOOL suc,NSArray *locs))cb;
+(instancetype)shareInstance;
+(NSString *)digestAry:(NSArray *)ary;
@end
