//
//  BlueTooth_GameKit_VC.m
//  day52-sensorNUIDynamic
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "BlueTooth_GameKit_VC.h"
#import <GameKit/GameKit.h>

@interface BlueTooth_GameKit_VC()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKPeerPickerControllerDelegate>

@property (nonatomic,strong)UIImageView *iv;
@property (nonatomic,strong)UIButton *connect;
@property (nonatomic,strong)UIButton *chooseImg;
@property (nonatomic,strong)UIButton *send;

@property (nonatomic,strong)GKSession *session;

@end

@implementation BlueTooth_GameKit_VC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}



-(void)initUI{
    self.iv = [[UIImageView alloc] init];
    [self.view addSubview:self.iv];
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(@0);
        make.width.equalTo(self.view).multipliedBy(.5);
        make.height.equalTo(self.view).multipliedBy(.5);
    }];
    self.iv.backgroundColor=[UIColor orangeColor];
    
    UIButton * (^newb)(NSString *title)=^(NSString *title){
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:title forState:UIControlStateNormal];
        [self.view addSubview:b];
        b.titleLabel.font=iBFont(22);
        [b addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return b;
    };
    self.connect=newb(@"connet");
    self.chooseImg=newb(@"chooseImg");
    self.send=newb(@"sendImg");
    
    
    [self.connect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).multipliedBy(0.25);
        make.top.equalTo(self.iv.mas_bottom).offset(30);
    }];
    [self.chooseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_right).multipliedBy(0.5);
        make.top.equalTo(self.iv.mas_bottom).offset(30);
    }];
    [self.send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_right).multipliedBy(0.75);
        make.top.equalTo(self.iv.mas_bottom).offset(30);
    }];
    
    
}


-(void)onBtnClick:(UIButton * )sender{
    if(sender == self.connect){
        GKPeerPickerController *picker = [[GKPeerPickerController alloc]init];
        picker.delegate=self;
        [picker show];
    }else if (sender == self.chooseImg){
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])return ;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    }else if (sender == self.send){
        NSData *data = UIImageJPEGRepresentation(self.iv.image, 0.5);
        [self.session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
    }
}


#pragma --mark
#pragma --mark   delegate

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session {
    self.session=session;
    [self.session setDataReceiveHandler:self withContext:nil];
    [picker dismiss];
    
}


- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    
}

-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context{
    self.iv.image=[UIImage imageWithData:data];
}




-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    self.iv.image=img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}






@end
