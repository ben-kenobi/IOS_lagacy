//
//  TestVC.m
//  day27-network
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "TestVC.h"
#import "SSZipArchive.h"

@interface TestVC ()<NSURLSessionDownloadDelegate>

@property (nonatomic,weak)UIImageView *iv;
@property (nonatomic,weak)UIView *prov;
@property (nonatomic,weak)UIButton *start;
@property (nonatomic,weak)UIButton *resume;
@property (nonatomic,weak)UIButton *stop;
@property (nonatomic,strong)NSURLSession *session;
@property (nonatomic,strong)NSURLSessionDownloadTask *task;
@property (nonatomic,strong)NSData *resumdata;
@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *iv=[[UIImageView alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-100}];
    self.iv=iv;
    [self.view addSubview:iv];

    UIView *  prov=[[UIView alloc] initWithFrame:(CGRect){0,0,0,30}];
    [prov setBackgroundColor:[UIColor randomColor]];
    [self.view addSubview:prov];
    self.prov=prov;
    prov.cy=self.view.cy;
    
    __block int i=2;
    UIButton *(^newb)(UIView *,NSString *)=^(UIView *sup,NSString *title){
        UIButton *b=[[UIButton alloc] initWithFrame:(CGRect){20,i*30,80,30}];
        [b setTitle:title forState:UIControlStateNormal];
        [b setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [b setBackgroundColor:[UIColor randomColor]];
        i+=2;
        [sup addSubview:b];
        [b addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    };
    
    self.start=newb(self.view,@"start");
    
    self.stop=newb(self.view,@"stop");
    self.resume=newb(self.view,@"resume");
}
-(void)onBtnClicked:(id)sender{
    if(sender==self.start){
        if(!self.resumdata){
            self.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
            self.task=[self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:iURL(@"http://localhost/resources/bigthing.zip") cachePolicy:1 timeoutInterval:15] ];
            [self.task resume];
            NSLog(@"start");
        }else{
            [self onBtnClicked:self.resume];
              NSLog(@"resume");
        }
    }else if(sender==self.resume){
        self.task=[self.session downloadTaskWithResumeData:self.resumdata];
        [self.task resume];
    }else if(sender==self.stop){
        [self.task cancelByProducingResumeData:^(NSData *resumeData) {
            NSLog(@"%@",resumeData);
            [resumeData writeToFile:@"/Users/apple/Desktop/xxxx.xml" atomically:YES];
            self.resumdata=resumeData;
        }];
        self.task=0;
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSString *str=@"YnBsaXN0MDDUAQIDBAUGc3RYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS"
    "AAGGoK8QGQcIP0BGR05PUFFSU1RVNVZXY2RlZmdoaW5VJG51bGzfEBsJCgsMDQ4PEBES"
    "ExQVFhcYGRobHB0eHyAhIiMkJSYnKCklKywtLi8nJiYmJDU2JjgmOiY8PT5TJDEyUiQz"
    "UyQyNVMkMTdSJDRTJDIxUyQxM1YkY2xhc3NSJDVTJDE4UiQ2UyQyMlMkMTRSJDdTJDE5"
    "UyQxMFIkOFIkMFMkMTVTJDIzUiQ5UyQxMVIkMVMkMjRTJDE2UiQyUyQyMIAIgAKAAIAK"
    "gAOAD4ACgBiABoANgAeAEIAKgACAAIAAgAgQAoALgACACYAAEAmAAIAMEBaADgjTQRBC"
    "JkRFV05TLmJhc2VbTlMucmVsYXRpdmWAAIAFgARfECdodHRwOi8vbG9jYWxob3N0L3Jl"
    "c291cmNlcy9iaWd0aGluZy56aXDSSElKS1okY2xhc3NuYW1lWCRjbGFzc2VzVU5TVVJM"
    "okxNVU5TVVJMWE5TT2JqZWN0I0AuAAAAAAAAEAEJEQGEEAAjAAAAAAAAAAAjAAAAAAAA"
    "AAAT//////////9TR0VU01hZEFpeYldOUy5rZXlzWk5TLm9iamVjdHOjW1xdgBGAEoAT"
    "o19gYYAUgBWAFoAXXxAPQWNjZXB0LUVuY29kaW5nVkFjY2VwdF8QD0FjY2VwdC1MYW5n"
    "dWFnZV1nemlwLCBkZWZsYXRlUyovKlV6aC1jbtJISWprXE5TRGljdGlvbmFyeaJsbVxO"
    "U0RpY3Rpb25hcnlYTlNPYmplY3TSSElvcFxOU1VSTFJlcXVlc3SicXJcTlNVUkxSZXF1"
    "ZXN0WE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0XV2VHJvb3SAAQAIABEAGgAjAC0A"
    "MgA3AFMAWQCSAJYAmQCdAKEApACoAKwAswC2ALoAvQDBAMUAyADMANAA0wDWANoA3gDh"
    "AOUA6ADsAPAA8wD3APkA+wD9AP8BAQEDAQUBBwEJAQsBDQEPAREBEwEVARcBGQEbAR0B"
    "HwEhASMBJQEnASkBKwEtAS4BNQE9AUkBSwFNAU8BeQF+AYkBkgGYAZsBoQGqAbMBtQG2"
    "AbkBuwHEAc0B1gHaAeEB6QH0AfgB+gH8Af4CAgIEAgYCCAIKAhwCIwI1AkMCRwJNAlIC"
    "XwJiAm8CeAJ9AooCjQKaAqMCtQK4Ar0AAAAAAAACAQAAAAAAAAB3AAAAAAAAAAAAAAAA"
    "AAACvw==";
//    [str dataUsingEncoding:4];
//    NSData *data=[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:4]);
   
  
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    [SSZipArchive unzipFileAtPath:location.path toDestination:@"/Users/apple/Desktop/aaa"];
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:@"/Users/apple/Desktop/12312312" error:0];
    NSLog(@"over");
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.2 animations:^{
            self.prov.w=self.view.w*((float)totalBytesWritten/totalBytesExpectedToWrite);
        }];
    });
}


@end
