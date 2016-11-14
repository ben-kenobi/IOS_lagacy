//
//  DSHomeModel.h
//  DS04
//
//  Created by Ricky on 15/6/29.
//  Copyright (c) 2015年 Ricky. All rights reserved.
//

#import "JSONModel.h"

@class DSFamousList;
@class DSFocusList;
@class DSGroupList;
@class DSGuessList;

@protocol DSFamousModel;
@protocol DSFocusModel;
@protocol DSGroupModel;
@protocol DSGuessModel;

#pragma mark --首页

@interface DSHomeModel : JSONModel

@property (nonatomic, strong) DSFamousList *famous;
@property (nonatomic, strong) DSFocusList *focus;
@property (nonatomic, strong) DSGroupList *group;
@property (nonatomic, strong) DSGuessList  *guess;

@end

#pragma mark --名店推荐

@interface DSFamousList : JSONModel

@property (nonatomic, copy) NSArray <DSFamousModel>* list;

@end

@interface DSFamousModel : JSONModel

/* id*/
@property (nonatomic, assign) int id;
/* 封面字段*/
@property (nonatomic, copy) NSString *cover;
/*距离字段*/
@property (nonatomic, assign) int distance;
/*简介*/
@property (nonatomic, copy) NSString *intro;
/*名称*/
@property (nonatomic, copy) NSString *name;
/*评分*/
@property (nonatomic, assign) int score;


@end

#pragma mark --分类

@interface DSGroupList : JSONModel

@property (nonatomic, copy) NSArray <DSGroupModel>*list;

@end

@interface DSGroupModel : JSONModel

/* 封面*/
@property (nonatomic, copy) NSString *cover;
/*id*/
@property (nonatomic, assign) int id;
/*标题*/
@property (nonatomic, copy) NSString *title;

@end

#pragma mark -- 广告Model

@interface DSFocusList : JSONModel
@property (nonatomic, copy) NSArray <DSFocusModel>*list;
@end

@interface DSFocusModel : JSONModel

/*封面*/
@property (nonatomic, copy) NSString *cover;
/*id*/
@property (nonatomic, assign) int id;
/*网页链接*/
@property (nonatomic, copy) NSString *link;
/*资源id*/
@property (nonatomic, copy) NSString *res_id;
/*资源名字*/
@property (nonatomic, copy) NSString *res_name;
/*标题*/
@property (nonatomic, copy) NSString *title;

@end

#pragma mark --猜你喜欢

@interface DSGuessList : JSONModel
@property (nonatomic,copy) NSArray <DSGuessModel>*list;
@end

@interface DSGuessModel :JSONModel
/*封面*/
@property (nonatomic, copy) NSString *cover;
/*id*/
@property (nonatomic, assign) int id;
/*简介*/
@property (nonatomic, copy) NSString *intro;
/*价格*/
@property (nonatomic, copy) NSString *price;
/*标题*/
@property (nonatomic, copy) NSString *title;


@end

