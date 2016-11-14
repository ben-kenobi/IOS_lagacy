
//
//  QRCodeVC.m
//  day54-QRCodeNContactsNstaticlibs
//
//  Created by apple on 15/12/27.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "QRCodeVC.h"
#import <AVFoundation/AVFoundation.h>

#import <SafariServices/SafariServices.h>

#import "YFQRScanV.h"

@interface QRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong)AVCaptureDeviceInput *input;
@property (nonatomic,strong)AVCaptureMetadataOutput *output;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *layer;
@property (nonatomic,strong)YFQRScanV *scanv;

@end

@implementation QRCodeVC


-(void)initUI{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input=[[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc] init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    NSLog(@"%@",self.output.availableMetadataObjectTypes);
//    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.session= [[AVCaptureSession alloc] init];
    
    if([self.session canAddInput:self.input]){
        [self.session addInput:self.input];
    }
    if([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
    
//    self.layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
//    self.layer.frame=self.view.layer.bounds;
//    [self.view.layer addSublayer:self.layer];
    
    
    self.scanv = [[YFQRScanV alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.scanv];
    
    self.layer=(AVCaptureVideoPreviewLayer *)self.scanv.layer;
    self.layer.session=self.session;
    
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if(metadataObjects .count >0){
        [self.session stopRunning];
//        [self.layer removeFromSuperlayer];
        [self.scanv removeFromSuperview];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"%@",obj.stringValue);
        if([obj.stringValue hasPrefix:@"http://"]||[obj.stringValue hasPrefix:@"https://"]){
            SFSafariViewController *sf = [[SFSafariViewController alloc]initWithURL:iURL(obj.stringValue)];
            [self presentViewController:sf animated:YES completion:nil];
        }
    }
}

@end
