//
//  YFHomeVC.m
//  day30-neteasenews02
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomeVC.h"
#import "YFBanner.h"
#import "YFNewsV.h"
@interface YFHomeVC ()


@end

@implementation YFHomeVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YFBanner *ban=[[YFBanner alloc] initWithFrame:(CGRect){0,20,self.view.w,40}];
    [self.view addSubview:ban];
    [ban setBackgroundColor:[UIColor colorWithWhite:0.889 alpha:1.000]];
    
    YFNewsV *news=[[YFNewsV alloc] initWithFrame:(CGRect){0,60,self.view.w,self.view.h-60}];
    [self.view addSubview:news];
    [news setOnChange:^(NSIndexPath *path) {
        [ban scrollToIdx:path];
    }];
    
    
    [IUtil get:iURL(@"http://localhost/news/topic_news.json") cache:1 callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(data&&!error){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            [news appendDatas:[dict allValues][0]];
            [ban appendDatas:[dict allValues][0]];
        }
    }];
    
    
    
    [ban setOnChange:^(NSIndexPath *idx) {
        [news scrollToItemAtIndexPath:idx atScrollPosition:0 animated:YES];
    }];
    
}




@end
