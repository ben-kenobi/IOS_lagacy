//
//  HMCollectionViewModel.m
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import "HMCollectionViewModel.h"

@implementation HMCollectionViewModel
+(instancetype)collectionViewModelWithDict:(NSDictionary *)dict{
    
    HMCollectionViewModel *model = [[HMCollectionViewModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    
    return model;

}
@end
