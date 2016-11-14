//
//  UploadVC.m
//  day27-network
//
//  Created by apple on 15/11/2.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "UploadVC.h"
#import "YFSelector.h"
#import "YFevaluator.h"

@interface UploadVC ()
@property (nonatomic,weak)YFSelector *sel;
@property (nonatomic,weak)YFevaluator *eva;
@end

@implementation UploadVC


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor randomColor]];
    YFSelector *sel=[[YFSelector alloc]initWithFrame:(CGRect){100,100,100,30}];
    [sel setBackgroundColor:[UIColor clearColor]];
    sel.title=@"ljefklw";
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBtnClicked:)];
    [sel addGestureRecognizer:tap];
    [self.view addSubview:sel];
    self.sel=sel;
    [self.sel.layer setMasksToBounds:NO];
    
    YFevaluator *eva=[[YFevaluator alloc] initWithFrame:(CGRect){100,150,120,30}];
    [eva setBackgroundColor:[UIColor clearColor]];
    eva.count=5;
    eva.unit=.5;
    [self.view addSubview:eva];
    self.eva=eva;
    self.eva.percent=0;
    
}

-(void)onBtnClicked:(id)sender{
    self.sel.selected=!self.sel.selected;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     NSString *boundary=@"--------------1234566";
    NSMutableURLRequest *req=[NSMutableURLRequest requestWithURL:iURL(@"http://localhost/upload/upload.php") cachePolicy:1 timeoutInterval:15];
    
    req.HTTPMethod=@"POST";
    [req setValue:[@"multipart/form-data; boundary=" stringByAppendingString:boundary] forHTTPHeaderField:@"Content-Type"];
    
    [[[NSURLSession sharedSession]uploadTaskWithRequest:req fromData:[IUtil uploadBodyWithBoundary:boundary file:@"/Users/apple/Desktop/aa.txt" name:@"userfile" filename:0] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:4]);
    }] resume];
    
    
//    [IUtil uploadFile:@"/Users/apple/Desktop/aa.txt" name:@"userfile" filename:0 toURL:iURL(@"http://localhost/upload/upload.php") callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:4]);
//    }];
//    
//    [IUtil multiUpload:@[@{@"file":@"/Users/apple/Desktop/123.png",@"name":@"userfile[]"},@{@"file":@"/Users/apple/Desktop/confirm.png",@"name":@"userfile[]",@"filename":@"22222"},@{@"file":@"/Users/apple/Desktop/aa.txt",@"name":@"userfile2",@"filename":@"11111"},@{@"name":@"username",@"value":@"aerwer"},@{@"name":@"password",@"value":@"123123"}] toURL:iURL(@"http://localhost/upload/upload-m.php") callBack:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:4]);
//    }];
}



@end
