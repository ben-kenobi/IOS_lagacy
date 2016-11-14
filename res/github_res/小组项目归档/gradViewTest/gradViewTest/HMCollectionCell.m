//
//  HMCollectionCell.m
//  gradViewTest
//
//  Created by 1 on 15/11/11.
//  Copyright © 2015年 stdio dollar. All rights reserved.
//

#import "HMCollectionCell.h"
#import "UIImageView+WebCache.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"


@interface HMCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *totalView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;

@end

@implementation HMCollectionCell


- (IBAction)player:(id)sender {
    
    NSLog(@"player");
    
    NSURL *url = [NSURL URLWithString:self.model.url];
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    
    AVPlayer *player = [AVPlayer playerWithURL:url];
    
    playerVC.player = player;
    [player play];
    
    [self.VC presentViewController:playerVC animated:YES completion:^{
        
    }];
    
}
//"length" : "36",
//"url" : "http:\/\/127.0.0.1\/resources\/videos\/minion_13.mp4",
//"image" : "http:\/\/127.0.0.1\/resources\/images\/minion_13.png",
//"ID" : "13",
//"name" : "小黄人 第13部"

-(void)setModel:(HMCollectionViewModel *)model{
    
    _model = model;
    
    NSURL *url = [NSURL URLWithString:model.image];
    
    [self.imageView sd_setImageWithURL:url];
    
    self.titleLabel.text = model.name;
    
    self.playerLengthLabel.text = model.length;
    
    self.IDLabel.text = model.ID;
    
    self.layer.cornerRadius = 20;
    
}

@end
