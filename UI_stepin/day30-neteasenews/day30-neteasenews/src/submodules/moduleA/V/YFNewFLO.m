//
//  YFNewFLO.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFNewFLO.h"

@implementation YFNewFLO

+(instancetype)loWithClz:(Class)clz{
    YFNewFLO *lo = [[YFNewFLO alloc] init];
    

    lo.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if ([clz isSubclassOfClass:NSClassFromString(@"YFBanner")] ) {
        
        lo.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    }else
    {
        lo.itemSize = CGSizeMake(iScreenW,iScreenH - 40);
        
        lo.minimumInteritemSpacing = 0;
        
        lo.minimumLineSpacing = 0;
        
    }
    
    return lo;
}

@end
