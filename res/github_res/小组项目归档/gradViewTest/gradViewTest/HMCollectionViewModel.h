//
//  HMCollectionViewModel.h
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//
//"length" : "36",
//"url" : "http:\/\/127.0.0.1\/resources\/videos\/minion_13.mp4",
//"image" : "http:\/\/127.0.0.1\/resources\/images\/minion_13.png",
//"ID" : "13",
//"name" : "小黄人 第13部"
#import <Foundation/Foundation.h>

@interface HMCollectionViewModel : NSObject

@property(nonatomic,copy)NSString *length;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *name;

+(instancetype)collectionViewModelWithDict:(NSDictionary *)dict;
@end
