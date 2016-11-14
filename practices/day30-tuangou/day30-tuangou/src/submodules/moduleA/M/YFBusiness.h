//
//  YFBusiness.h
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBusiness : NSObject
/** 店名 */
@property (nonatomic, copy) NSString *name;
/** 纬度 */
@property (nonatomic, assign) float latitude;
/** 经度 */
@property (nonatomic, assign) float longitude;
@end
