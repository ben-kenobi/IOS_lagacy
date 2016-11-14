//
//  YFMetaTool.m
//  day30-tuangou
//
//  Created by apple on 15/11/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFMetaTool.h"
#import "YFCity.h"
#import "YFCategory.h"
#import "YFSort.h"
#import "MJExtension.h"
#import "TFDeal.h"
#import "YFCityGroup.h"
@implementation YFMetaTool

+ (NSArray *)cities
{
    static NSArray *_cities;
    static long l=0;
    dispatch_once(&l, ^{
        _cities = [YFCity objectArrayWithFilename:@"cities.plist"];
//        _cities=[IUtil aryWithClz:[YFCity class] fromFile:iRes(@"cities.plist")];

    });
    return _cities;
}

+(NSArray *)cityGroups{
    static NSArray *_cityGroups;
    if(_cityGroups==nil){
        _cityGroups=[YFCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}

+ (NSArray *)categories
{
    static NSArray *_categories;
    if (_categories == nil) {
        _categories = [YFCategory objectArrayWithFilename:@"categories.plist"];;
    }
    return _categories;
}


+ (NSArray *)sorts
{
    static NSArray *_sorts;
    if (_sorts == nil) {
        _sorts = [YFSort objectArrayWithFilename:@"sorts.plist"];;
    }
    return _sorts;
}


+ (YFCategory *)categoryWithDeal:(TFDeal *)deal
{
    NSArray *cs = [self categories];
    NSString *cname = [deal.categories firstObject];
    for (YFCategory *c in cs) {
        if ([cname isEqualToString:c.name]) return c;
        if ([c.subcategories containsObject:cname]) return c;
    }
    return nil;
}
@end
