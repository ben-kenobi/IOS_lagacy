
//
//  VideoVC03.m
//  day55-videoNaudios
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "VideoVC03.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface VideoVC03 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation VideoVC03

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self videoCompression];
}

// videoCompression
-(void)videoCompression{
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(![UIImagePickerController isSourceTypeAvailable:type]){
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.sourceType=type;
//    picker.mediaTypes=@[(NSString *)kUTTypeMovie];
    picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    [self presentViewController:picker animated:YES completion:nil];
}







- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self export:info[UIImagePickerControllerMediaURL]];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
   
}



-(void)export:(NSURL *)url{
    AVAsset *asse=[AVAsset assetWithURL:url];
    AVAssetExportSession *session=[[AVAssetExportSession alloc] initWithAsset:asse presetName:AVAssetExportPresetLowQuality];
    session.outputURL=iFURL([@"test.mov" strByAppendToDocPath]);
    session.outputFileType=AVFileTypeQuickTimeMovie;
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"export mov success");
    }];
}

@end
