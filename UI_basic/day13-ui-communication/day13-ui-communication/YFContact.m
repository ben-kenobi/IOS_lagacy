//
//  YFContact.m
//  day13-ui-communication
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFContact.h"

@implementation YFContact

+(instancetype)contactWithDict:(NSDictionary *)dict{
    YFContact *obj= [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.num=[aDecoder decodeObjectForKey:@"num"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.num forKey:@"num"];
}

@end
