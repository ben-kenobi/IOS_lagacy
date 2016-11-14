//
//  YFImgVC.m
//  day28-project01
//
//  Created by apple on 15/11/1.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFImgVC.h"
#import "MBProgressHUD+ZJ.h"

@interface YFImgVC ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIScrollView *sv;
@property (nonatomic,weak)UIImageView *iv;
@end

@implementation YFImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    self.title=self.dict[@"key"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIScrollView *sv=[[UIScrollView alloc] init];
    [self.view addSubview:sv];
    [sv setShowsHorizontalScrollIndicator:NO];
    [sv setShowsVerticalScrollIndicator:NO];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.sv=sv;
    UIImageView *iv=[[UIImageView alloc] init];
    [sv addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [sv setMaximumZoomScale:3];
    [sv setMinimumZoomScale:.3];
    sv.delegate=self;
    self.iv=iv;
    [self loadUrl];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.iv;
}
-(void)loadUrl{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(self.dict[@"val"]) cachePolicy:1 timeoutInterval:5];
    [MBProgressHUD showMessage:@"loading..."];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [NSThread sleepForTimeInterval:.5];
        if(data&&!error){
            UIImage *img=[UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.iv.image=img;
            });
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        
    }] resume];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIViewController popVC];
}

@end
