//
//  YFFocusList.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "JSONModel.h"

@protocol YFFocus;


@interface YFFocusList : JSONModel

@property (nonatomic,strong)NSArray<YFFocus>* list;
@end
