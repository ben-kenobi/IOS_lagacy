//
//  YFCate.m
//  day14-ui-pwdmodal
//
//  Created by apple on 15/10/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFCate.h"

@implementation YFCate

+(instancetype)cateWithDict:(NSDictionary *)dict{
    YFCate *cate=[[self alloc ] init];
    [cate setValuesForKeysWithDictionary:dict];
    return cate;
}

-(NSMutableArray *)apps{
    if(!_apps){
        _apps=[NSMutableArray array];
    }
    return _apps;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.apps forKey:@"apps"];
//    [aCoder encodeBool:self.show forKey:@"show"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.apps=[aDecoder decodeObjectForKey:@"apps"];
//        self.show=[aDecoder decodeBoolForKey:@"show"];
        self.apps=[NSMutableArray arrayWithArray:self.apps];
    }
    return self;
}

@end
