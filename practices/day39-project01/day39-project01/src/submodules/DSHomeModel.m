//
//  DSHomeModel.m
//  DS04
//
//  Created by Ricky on 15/6/29.
//  Copyright (c) 2015年 Ricky. All rights reserved.
//

#import "DSHomeModel.h"

@implementation DSHomeModel


@end

@implementation DSFamousList



@end

@implementation DSFamousModel



@end

@implementation DSFocusList



@end

@implementation DSFocusModel

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.title = [aDecoder decodeObjectForKey:@"title"];
        
    }
    
    return self;
    
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:@"title" forKey:@"title"];
    
}

@end

@implementation DSGuessList



@end

@implementation DSGuessModel




@end

@implementation DSGroupList



@end

@implementation DSGroupModel


@end