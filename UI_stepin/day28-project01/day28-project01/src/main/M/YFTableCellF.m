//
//  YFTableCellF.m
//  day28-project01
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTableCellF.h"

@implementation YFTableCellF


-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateF];
}
-(void)updateF{
    CGFloat top=8,lef=15;
    CGFloat lefw=iScreenW*.35,rigw=iScreenW*.65;
    CGSize size1=[_dict[@"key"] boundingRectWithSize:(CGSize){lefw-lef*2,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:0].size ;
    
    self.keyf=(CGRect){lef,top,size1};
    
    CGSize size2=[[_dict[@"val"] lastPathComponent] boundingRectWithSize:(CGSize){rigw-lef*2,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:0].size;
    self.valf=(CGRect){lef+lefw,top,size2};
    
    CGFloat h1,h2;
    h1=CGRectGetMaxY(self.keyf);
    h2=CGRectGetMaxY(self.valf);
    h1=h1>h2?h1:h2;
    self.keyf=(CGRect){lef,(h1-size1.height)*.5,size1};
    self.valf=(CGRect){lef+lefw,(h1-size2.height)*.5,size2};
    self.height=h1+top;
}

+(instancetype)fWithDict:(NSDictionary *)dict{
   YFTableCellF *f= [[YFTableCellF alloc] init];
    [f setDict:dict];
    return f;
}

@end
