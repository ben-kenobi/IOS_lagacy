//
//  FaceVC.m
//  day53-msgNfaceNcloud
//
//  Created by apple on 15/12/26.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "FacePPVC.h"
#import "FaceppAPI.h"
#import "SVProgressHUD.h"

@interface FacePPVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIImageView *iv;

@property (nonatomic,strong)UIButton *shoot;
@property (nonatomic,strong)UIButton *album;
@end






@implementation FacePPVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [FaceppAPI initWithApiKey:@"041f1f0734313623c6907115fd49b5b5" andApiSecret:@"EoCOnki08cgUy1ejxjh6yXo-iE8F37vW"
                    andRegion:APIServerRegionCN];
    [FaceppAPI setDebugMode:YES];
    [self initUI];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *img = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
        img=img(@"wo");
       FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:UIImageJPEGRepresentation(img, 0.5)];
        NSArray *faceary = result.content[@"face"];
        if (!faceary.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"failure" message:@"识别失败" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil] show ];
            }) ;
            return ;
        }
        NSDictionary *att = faceary[0][@"attribute"];
        NSString *age = att[@"age"][@"value"];
        NSString *sex = att[@"gender"][@"value"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"success" message:iFormatStr(@"age=%@,sex=%@",age,sex) delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil] show ];
        });
        
        
        NSDictionary *pos = faceary[0][@"position"];
        
        // the values return is percentage value
        CGFloat w = [pos[@"width"] floatValue];
        CGFloat h = [pos[@"height"] floatValue];
        CGFloat x = [pos[@"center"][@"x"] floatValue] - w * 0.5;
        CGFloat y = [pos[@"center"][@"y"] floatValue] - h * 0.5;
        
        CGSize size = img.size;
        
        UIGraphicsBeginImageContextWithOptions(size, 0, 0);
        [img drawAtPoint:(CGPoint){0,0}];
        
        UIImage *subface = img(@"me");
        [subface drawInRect:(CGRect){x*0.01*size.width,y*0.01*size.height,w*0.01*size.width,h*0.01*size.height}];
        
        UIImage *newimg=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iv.image=newimg;
            [self.iv mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(@0);
            }];
        });
        
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (UIImage*)fixOrientation:(UIImage*)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage* img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


-(void)onbClick:(UIButton *)sender{
    if(sender==self.album){
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            [SVProgressHUD showErrorWithStatus:@"album unavailable!" maskType:SVProgressHUDMaskTypeBlack];
            return ;
        }
        UIImagePickerController *picker =[[UIImagePickerController alloc] init];
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    }else if (sender==self.shoot){
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [SVProgressHUD showErrorWithStatus:@"camera unavailable!" maskType:SVProgressHUDMaskTypeBlack];
            return ;
        }
        UIImagePickerController *picker =[[UIImagePickerController alloc] init];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)initUI{
    self.iv = [[UIImageView alloc] init];
    self.iv.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.iv];
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.height.equalTo(@300);
    }];
    
    
    UIButton *(^newb)(NSString *)=^(NSString *title){
        UIButton *b = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:title forState:0];
        [self.view addSubview:b];
        b.titleLabel.font=iBFont(22);
        [b addTarget:self action:@selector(onbClick:) forControlEvents:UIControlEventTouchUpInside];
        return b ;
    };
    
    
    self.shoot = newb(@"shoot");
    self.album = newb(@"album");
    [self.shoot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-30);
        make.top.equalTo(self.iv.mas_bottom).offset(20);
    }];
    [self.album mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(30);
        make.top.equalTo(self.iv.mas_bottom).offset(20);
    }];
}
    
    
    
@end
