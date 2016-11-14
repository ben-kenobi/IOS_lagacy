//
//  DLImgVC.m
//  day27-network
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "DLImgVC.h"

@interface DLImgVC ()
@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,strong)dispatch_queue_t que;
@end

@implementation DLImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *iv=[[UIImageView alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-100}];
    self.iv=iv;
    [self.view addSubview:iv];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.que=dispatch_queue_create("111", DISPATCH_QUEUE_SERIAL);
    
    [self asynLoadImgWithURL:iURL(@"http://localhost/resources/images/minion_01.png")];
    
}
-(void)asynLoadImgWithURL:(NSURL *)url{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableData *imgdata=[NSMutableData data];
        long long total=[self length:url];
        long long to=0,from=to;
        NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
        req.HTTPMethod=@"POST";
        while (from<total){
            to=from+1024;
            [req setValue:[NSString stringWithFormat:@"bytes=%lld-%lld",from,to] forHTTPHeaderField:@"range"];
            [imgdata appendData:[NSURLConnection sendSynchronousRequest:req returningResponse:0 error:0]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.iv.image=[UIImage imageWithData:imgdata];
            });
            from=to+1;
            [NSThread sleepForTimeInterval:.05];
            
            
        }
    });
    
}

-(long long)length:(NSURL*)url{
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod=@"HEAD";
    NSURLResponse *resp;
    [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:0];
    return resp.expectedContentLength;
}

@end
