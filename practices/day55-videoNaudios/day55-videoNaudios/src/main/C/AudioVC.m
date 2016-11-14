//
//  SoundEffectVC.m
//  day55-videoNaudio
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "AudioVC.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioVC ()
@property (nonatomic,strong)AVAudioPlayer *ap;

@property (nonatomic,strong)AVAudioRecorder *reco;
@property (nonatomic,strong)CADisplayLink *cdl;

@end

@implementation AudioVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self recorderTest];

}


-(void)recorderTest{
    
    // when use real device
   AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    
    
    self.reco=[[AVAudioRecorder alloc] initWithURL:iFURL([@"record.wav" strByAppendToDocPath]) settings:@{AVSampleRateKey:@(600.0),AVNumberOfChannelsKey:@(1),AVLinearPCMBitDepthKey:@(8)} error:nil];
    
    self.reco.meteringEnabled=YES;
    [self.reco prepareToRecord];
    [self.reco record];
    [self cdl:NO];
//    dispatch_after(dispatch_time(0, 3e9), dispatch_get_main_queue(), ^{
//        [self.reco stop];
//    });
    
}
-(void)updateRecorder{
    static int count = 0 ;
    [self.reco updateMeters];
    CGFloat power=[self.reco averagePowerForChannel:0];
    if (power<-30) {
        count++;
        if (count>=120){
            [self.reco stop];
            [self cdl:YES];
            count=0;
        }
    }else{
        count=0;
    }
    printf("%d||||||||||%.2f\n",count,power);
   

}

-(void)cdl:(BOOL)pause{
    if(!_cdl){
        _cdl=[CADisplayLink displayLinkWithTarget:self  selector:@selector(updateRecorder)];
     [self.cdl addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    [_cdl setPaused:pause];
}

-(void)playerTest{
    self.ap = [[AVAudioPlayer alloc] initWithContentsOfURL:iURL(iRes(@"")) error:nil];
    
    self.ap.currentTime = 0 ;
    [self.ap prepareToPlay];
    [self.ap play];
}



@end
