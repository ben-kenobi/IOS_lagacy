//
//  YFHomeVC.m
//  day30-neteasenews
//
//  Created by apple on 15/11/7.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomeVC.h"
#import "YFBanner.h"
#import "YFNewsV.h"
@interface YFHomeVC ()

@property (nonatomic,weak)YFBanner *ban;
@property (nonatomic,weak)YFNewsV *news;

@end

@implementation YFHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor randomColor]];
    YFBanner *ban=[[YFBanner alloc] initWithFrame:(CGRect){0,0,self.view.w,40}];
    [ban setBackgroundColor:[UIColor colorWithWhite:0.814 alpha:1.000]];
    [self.view addSubview:ban];
    self.ban=ban;
    [ban setOnChange:^(NSInteger idx) {
        [self.news scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:0 animated:YES];
    }];
  
    
    
    YFNewsV *news=[[YFNewsV alloc] initWithFrame:(CGRect){0,40,self.view.w,self.view.h-40}];
    [self.view addSubview:news];
    [news setBackgroundColor:[UIColor whiteColor]];
    self.news=news;
    
    [self loadDataWithUrl:iURL(@"http://localhost/news/topic_news.json") cb:^(id datas){
        NSDictionary *dict=datas;
        [ban appendDatas:dict[@"tList"]];
        [news appendDatas:dict[@"tList"]];
    }];
    
    
}

-(void)loadDataWithUrl:(NSURL *)url cb:(void (^)(id)) cb{
    [[[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error&&data){
            id datas=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(cb)
                    cb(datas);
            });
        }
    }]resume];
}



@end
