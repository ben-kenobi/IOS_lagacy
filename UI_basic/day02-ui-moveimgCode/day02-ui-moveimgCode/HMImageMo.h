//
//  HMImageMo.h
//  day02-ui-moveimgCode
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMImageMo : NSObject
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *img;
-(id)initWithDict:(NSDictionary *)dict;
+(id)imageMoWithDict:(NSDictionary *)dict;
@end
