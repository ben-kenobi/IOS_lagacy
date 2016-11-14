
//
//  VideoVC02.m
//  day55-videoNaudios
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "VideoVC02.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

static NSString *videoUrl=@"http://127.0.0.1/resources/videos/minion_01.mp4";

@interface VideoVC02 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIImageView *iv;
@property (nonatomic,strong)MPMoviePlayerController *mpc;
@end

@implementation VideoVC02

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iv=[[UIImageView alloc] initWithFrame:(CGRect){0,0,self.view.w,200}];
    self.iv.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.iv];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self videoRecord];
}





// videoRecord
-(void)videoRecord{
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(![UIImagePickerController isSourceTypeAvailable:type]){
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.sourceType=type;
    
    //two value, one is kUTTypeImage ,another is kUTTypeMovie = public.movie
    picker.mediaTypes=@[(NSString *)kUTTypeMovie];
    
//    picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo
    
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeMovie]){
        if(!self.mpc){
            self.mpc=[[MPMoviePlayerController alloc]init];
            self.mpc.view.frame=self.view.bounds;
            [self.view addSubview:self.mpc.view];
            self.mpc.controlStyle=MPMovieControlStyleFullscreen;
        }
        
        NSURL *url =info[UIImagePickerControllerMediaURL];
        self.mpc.contentURL=url;
        [self.mpc play];
        
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            ALAssetsLibrary *al = [[ALAssetsLibrary alloc]init];
            [al writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
                if(!error){
                    NSLog(@"save success");
                }
            }];
        }
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}






// videoShoot
-(void)videoShoot{
    AVAsset *asse=[AVAsset assetWithURL:iURL(videoUrl)];
    AVAssetImageGenerator *imgGen=[[AVAssetImageGenerator alloc] initWithAsset:asse];
    
//     NSLog(@"%ld",asse.duration.value/asse.duration.timescale);
    
    [imgGen generateCGImagesAsynchronouslyForTimes:@[[NSValue valueWithCMTime:CMTimeMake(24*10, 24)]] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if(result!=AVAssetImageGeneratorSucceeded) return ;
        UIImage  *img=[[UIImage alloc] initWithCGImage:image];
//        NSLog(@"%ld---%ld---%ld",requestedTime.value,requestedTime.timescale,actualTime.value/actualTime.timescale);
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.iv.image=img;
        });
    }];
}






@end
