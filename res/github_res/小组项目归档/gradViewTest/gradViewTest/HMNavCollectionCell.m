//
//  HMNavCollectionCell.m
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import "HMNavCollectionCell.h"

@interface HMNavCollectionCell ()

@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation HMNavCollectionCell

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:_nameLabel];
    }
    
    return _nameLabel;

}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}

-(void)setName:(NSString *)name{
    
    _name = name;
    
    

    
    self.nameLabel.text = name;

}



@end
