//
//  YFScanVC.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFScanVC.h"
#import <AVFoundation/AVFoundation.h>
#import "YFDetailVC.h"
#import "MBProgressHUD+ZJ.h"

static const CGFloat kBorderW=60,kMargin=15;

@interface  YFScanVC ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

@property (nonatomic,weak)UIView *mask;
@property (nonatomic,strong)AVCaptureSession *session;

@end

@implementation YFScanVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    self.view.clipsToBounds=YES;
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden=YES;
}
-(void)initUI{
    UIView *mask=[[UIView alloc] init];
    _mask=mask;
    mask.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]CGColor];
    mask.layer.borderWidth=kBorderW;
    mask.frame=(CGRect){0,0,self.view.w+kBorderW+kMargin*2,self.view.h*.9};
//    mask.bounds=(CGRect){0,0,self.view.size};
    mask.center=self.view.innerCenter;
    mask.y=0;
    [self.view addSubview:mask];
    
    
    UIView *bottom=[[UIView alloc] initWithFrame:(CGRect){0,self.view.h*.9,self.view.w,self.view.h*.1}];
    bottom.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.7] ;
    [self.view addSubview:bottom];
    

    UIView *scan=[[UIView alloc] initWithFrame:(CGRect){kMargin,kBorderW,self.view.w-kMargin*2,self.view.h*.9-kBorderW*2}];
    scan.clipsToBounds=YES;
    [self.view addSubview:scan];
    
    CGFloat scanh=241;
    UIImageView *scanIv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    scanIv.frame=(CGRect){0,-scanh,scan.w,scanh};
    CABasicAnimation *ba=[CABasicAnimation animation];
    ba.keyPath=@"transform.translation.y";
    ba.byValue=@(scan.h);
    ba.duration=1;
    ba.repeatCount=MAXFLOAT;
    [scanIv.layer addAnimation:ba forKey:nil];
    [scan addSubview:scanIv];
    
    CGFloat btnh=18;
    CGPoint pos[4]={{0,0},{scan.w-btnh, 0},{0,scan.h-btnh},{scan.w-btnh,scan.h-btnh}};
    for(int i=1;i<5;i++){
        UIButton *btn=[[UIButton alloc] initWithFrame:(CGRect){pos[i-1],btnh,btnh}];
        [btn setImage:img(([NSString stringWithFormat:@"scan_%d",i])) forState:UIControlStateNormal];
        [scan addSubview:btn];
    }
    
    
    UIButton *btn=[[UIButton alloc] init];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame=(CGRect){0,self.view.h*.9,self.view.w,self.view.h*.1};
    [btn setBackgroundColor:[UIColor randomColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=1;
}

-(void)scan{
    AVCaptureDevice *dev=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *ip=[AVCaptureDeviceInput deviceInputWithDevice:dev error:nil];
    if(!ip) return ;
    
    AVCaptureMetadataOutput *op=[[AVCaptureMetadataOutput alloc] init];
    op.rectOfInterest=(CGRect){.1,0,.9,1};
    [op setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session=[[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    [self.session addInput:ip];
    [self.session addOutput:op];
    op.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,
                             AVMetadataObjectTypeEAN13Code,
                             AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer=[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    [self.session startRunning];
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if(metadataObjects.count>0){
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *mobj=[metadataObjects objectAtIndex:0];
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"aler" message:mobj.stringValue delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"rescan", nil];
        [aler show];
    }
}


-(void)onBtnClicked:(id)sender{
    NSInteger tag=[sender tag];
    if(tag==1){
//        [self scan];
        [self loadData];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [self dismiss];
    }else if(buttonIndex==1){
        [self.session startRunning];
    }
}

-(void)loadData{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(self.url) cachePolicy:1 timeoutInterval:5];
//    [MBProgressHUD showMessage:@"loading..."];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(data&&!error){
            NSArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                YFDetailVC *vc=[[YFDetailVC alloc] init];
                [vc setDict:ary[0]];
                [vc setConfirm:YES];
                [vc setTitle:@"签收单"];
                [UIViewController pushVC:vc];
            });
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
        });
        
    }] resume];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    if(!parent){
        self.navigationController.navigationBar.hidden=NO;
    }
}


@end
