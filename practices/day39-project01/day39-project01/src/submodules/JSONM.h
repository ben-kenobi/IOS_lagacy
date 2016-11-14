//
//  JSONM.h
//  day39-project01
//
//  Created by apple on 15/11/22.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "JSONModel.h"

@interface JSONM : JSONModel
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)int id;
@property (nonatomic,assign)int age;
@property (nonatomic,strong)JSONM *z;
@end
