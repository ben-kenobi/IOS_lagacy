//
//  HMGussMod.h
//  day4-ui-imageGuess
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMGussMod : NSObject

@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSArray *options;

+(instancetype)modWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
    


@end
