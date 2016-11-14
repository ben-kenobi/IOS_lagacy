
//
//  VideoVC.m
//  day55-videoNaudios
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "VideoVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


static NSString *videoUrl=@"http://127.0.0.1/resources/videos/minion_01.mp4";
@interface VideoVC ()
@property (nonatomic,strong)MPMoviePlayerController *mpc;

@property (nonatomic,strong)AVPlayerViewController* apvc;
@end
@implementation VideoVC

-(void)viewDidLoad{
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self avPlayerTest];
}

#pragma --mark
#pragma --mark AVPlayerTest  IOS9

-(AVPlayerViewController *)apvc{
    if(!_apvc){
        _apvc=[[AVPlayerViewController alloc] init];
        _apvc.player = [AVPlayer playerWithURL:iURL(videoUrl)];
          self.apvc.view.frame=self.view.bounds;
        [_apvc.player play];
        _apvc.view.backgroundColor=[UIColor whiteColor];

    }
    return _apvc;
}
-(void)avPlayerTest{
    
    [self presentViewController:self.apvc animated:YES completion:nil];
  
//    [self.view addSubview:self.apvc.view];
}





#pragma --mark
#pragma --mark moviewControllerTest
-(MPMoviePlayerController *)mpc{
    if(!_mpc){
        _mpc=  [[MPMoviePlayerController alloc] init];
        _mpc.view.frame=self.view.bounds;
        [_mpc setControlStyle:MPMovieControlStyleFullscreen];
        _mpc.view.backgroundColor=[UIColor whiteColor];
        [iNotiCenter addObserver:self selector:@selector(mpcNoti:) name:MPMoviePlayerPlaybackDidFinishNotification object:_mpc];

//         [iNotiCenter addObserver:self selector:@selector(mpcNoti:) name:MPMoviePlayerLoadStateDidChangeNotification object:_mpc];
    }
    return _mpc;
}

-(void)moviewControllerTest{
    [self.view addSubview:self.mpc.view];
    self.mpc.contentURL=iURL(videoUrl);
    [self.mpc prepareToPlay];
    [self.mpc play];
}
-(void)mpcNoti:(NSNotification *)noti{
    NSLog(@"%@",noti);

    if(noti.name == MPMoviePlayerPlaybackDidFinishNotification){
        NSInteger type = [noti.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
        if (type == MPMovieFinishReasonPlaybackEnded) {
            self.mpc.contentURL = iURL(@"http://127.0.0.1/resources/videos/minion_02.mp4");
            [self.mpc play];
        }else if(type == MPMovieFinishReasonPlaybackError){
            
        }else if (type == MPMovieFinishReasonUserExited){
            [_mpc stop];
            [self.mpc.view removeFromSuperview];
        }
        
    }else if (noti.name==MPMoviePlayerLoadStateDidChangeNotification){
        printf("MPMoviePlayerLoadStateDidChangeNotification");
    }
}





#pragma --mark
#pragma --mark viewMovieControllerTest
-(void)viewMovieControllerTest{
   MPMoviePlayerViewController *vc= [[MPMoviePlayerViewController alloc] initWithContentURL:iURL(videoUrl)];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
