//
//  YFContact.m
//  day13-ui-loginsb
//
//  Created by apple on 15/10/6.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFContact.h"

@implementation YFContact


-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.num forKey:@"num"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.num=[aDecoder decodeObjectForKey:@"num"];
    }
    return self;
}

+(instancetype)conWithDict:(NSDictionary *)dict{
    YFContact *con=[[self alloc] init];
    [con setValuesForKeysWithDictionary:dict];
    return con;
}

-(NSString *)description{
    return [@{@"name":_name,@"num":_num} description];
}
@end
