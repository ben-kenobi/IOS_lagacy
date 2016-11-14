//
//  AppModViewNib.m
//  day03-ui-appManagement
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 itheima. All rights reserved.
//
#import "AppModViewNib.h"
#import "AppMod.h"
#import "CoverViewCode.h"

@interface AppModViewNib()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak,nonatomic) UIView *mainV;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) BOOL stop;

@end


@implementation AppModViewNib

-(void) setMod:(AppMod *)mod andFrame:(CGRect)frame andMainV:(UIView *)mainV{
    self.mod=mod;
    _img.image=mod.img;
    _lab.text=mod.title;
    self.mainV=mainV;
    self.frame=frame;
    
}


-(void)setLabText:( UILabel  *)lab{
    NSMutableString *ms=[NSMutableString stringWithString:@"Downloading."];
    for(int i=0;i<_count%4;i++)
        [ms appendString:@"."];
    lab.text=ms;
   // NSLog(@"%@",ms);
    if(!_stop)
        [self performSelector:@selector(setLabText:) withObject:lab afterDelay:.5];
    _count++;
}

- (IBAction)btnClicked:(UIButton *)sender {
    CoverViewCode *cover =[CoverViewCode viewWithFrame:_mainV.frame andMod:self.mod];
    
    cover.alpha=0;
    
    _stop=NO;
    [self setLabText:cover.lab];
    
    [_mainV addSubview:cover];
    NSLog(@"%@\n%@",_mainV,cover);
    [UIView animateWithDuration:.7 animations:^{
        cover.alpha=.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:2 options:0 animations:^{
            cover.alpha=0;
        } completion:^(BOOL finished) {
            [cover removeFromSuperview];
            sender.enabled=false;
            _stop=YES;
        }];
    }];
   
}

@end
