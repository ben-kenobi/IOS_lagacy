//
//  SessionDLVC.m
//  day27-network
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "SessionDLVC.h"

@interface SessionDLVC ()<NSURLConnectionDataDelegate,NSURLSessionDownloadDelegate>

@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,assign)long long curlen;
@property (nonatomic,assign)long long total;
@property (nonatomic,strong)NSOutputStream *os;
@property (nonatomic,strong)NSFileHandle *fh;
@property (nonatomic,weak)UIProgressView *pro;

@property (nonatomic,weak)UIView *prov;
@end

@implementation SessionDLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *iv=[[UIImageView alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-100}];
    self.iv=iv;
    [self.view addSubview:iv];
    UIProgressView *pro=[[UIProgressView alloc]initWithFrame:(CGRect){0,0,300,30}];
    
    self.pro=pro;
    pro.center=self.view.center;
    pro.progress=.0;
    [pro setBackgroundColor:[UIColor randomColor]];
    [pro setProgressTintColor:[UIColor orangeColor]];
    
    [self.view addSubview:pro];
    
    
    UIView *  prov=[[UIView alloc] initWithFrame:(CGRect){0,0,0,30}];
    [prov setBackgroundColor:[UIColor randomColor]];
    [self.view addSubview:prov];
    self.prov=prov;
    prov.cy=self.view.cy;
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:@"/Users/apple/Desktop/22222" error:0];
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    [NSThread sleepForTimeInterval:.1];
    CGFloat progress=(CGFloat)totalBytesWritten/totalBytesExpectedToWrite;
    NSLog(@"%.2f",progress);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.pro setProgress:progress animated:YES];
        [UIView animateWithDuration:.2 animations:^{
            self.prov.w=self.view.w*progress;
        }];
        
    });
    
    
    [NSThread sleepForTimeInterval:.1];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init] ];
    
    [[session downloadTaskWithRequest:[NSURLRequest requestWithURL:iURL(@"http://localhost/resources/bigthing") cachePolicy:1 timeoutInterval:15]] resume];
    
    
    
    
    //
    //    [[[NSURLSession sharedSession] downloadTaskWithRequest:[NSURLRequest requestWithURL:iURL(@"http://localhost/resources/bigthing") cachePolicy:1 timeoutInterval:15] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    //        NSLog(@"%@",location.path);
    //        [[NSFileManager defaultManager]copyItemAtPath:location.path toPath:@"/Users/apple/Desktop/dlded" error:0];
    //    }]resume];
    
    
    
    
    
    //
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        NSURL *url=iURL(@"http://localhost/resources/bigthing");
    //        NSURLConnection *con=  [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15] delegate:self];
    //        [con start];
    //        [[NSRunLoop currentRunLoop] run];
    //    });
    
    
    
    
    //    NSInputStream *is=[NSInputStream inputStreamWithFileAtPath:@"/Users/apple/Desktop/aa.txt"]
    //    ;
    //    [is open];
    //    char dest[1000]={0};
    //    unsigned char buf[22];
    //    NSInteger idx=0;
    //    NSInteger len;
    //    while (len>0) {
    //        len=[is read:buf maxLength:22];
    //        for(int i=0;i<len;i++){
    //            dest[idx++]=buf[i];
    //        }
    //        printf("%ld\n",len);
    //    }
    //    printf("%s",dest);
    //
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.curlen=0;
    self.total=response.expectedContentLength;
    self.os=[NSOutputStream outputStreamToFileAtPath:@"/Users/apple/Desktop/qweqwe" append:NO];
    [self.os open];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    self.curlen+=data.length;
    NSLog(@"%.2f",(float)self.curlen/self.total);
    
    //
    //    if(!self.fh){
    //        [data writeToFile:@"/Users/apple/Desktop/qweqwe" atomically:YES];
    //        self.fh=[NSFileHandle fileHandleForWritingAtPath:@"/Users/apple/Desktop/qweqwe"];
    //
    //        NSLog(@"%lld",[self.fh seekToEndOfFile]);
    //    }else
    //       [self.fh writeData:data];
    
    
    [self.os write:data.bytes maxLength:data.length];
    
    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.os close];
    //    [self.fh closeFile];
    //    self.fh=0;
    NSLog(@"%@",[[NSFileManager defaultManager] attributesOfItemAtPath:@"/Users/apple/Desktop/qweqwe" error:0]);
    NSLog(@"%@", [[NSFileManager defaultManager] attributesOfFileSystemForPath:@"/Users/apple/Desktop/qweqwe" error:0]);
    
}

@end
