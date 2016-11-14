//
//  YFQRScanV.m
//  day54-QRCodeNContactsNstaticlibs
//
//  Created by apple on 15/12/27.
//  Copyright © 2015年 yf. All rights reserved.
//

#import "YFQRScanV.h"
#import <AVFoundation/AVFoundation.h>

@interface YFQRScanV ()
@property (nonatomic,weak)UIImageView *rect;
@property (nonatomic,weak)UIImageView *line;


@end

@implementation YFQRScanV


+(Class)layerClass{
    return [AVCaptureVideoPreviewLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        [self initUI];
        [self startScan];
    }
    return self;
}

-(void)startScan{
    self.line.y=-5;
    [UIView animateWithDuration:2.8 animations:^{
        self.line.y=self.rect.b;
    } completion:^(BOOL finished) {
        [self startScan];
    }];
}

-(void)initUI{
    UIImageView *rect = [[UIImageView alloc] initWithImage:img(@"pick_bg")];
    [self addSubview:rect];
    rect.layer.masksToBounds=YES;
    self.rect=rect;
    [rect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.equalTo(@280);
    }];
    UIImageView *line = [[UIImageView alloc] initWithImage:img(@"line.png")];
    [rect addSubview:line];
    line.w=rect.w;
    self.line=line;
    self.backgroundColor=iColor(0, 0, 0, 0.4);
   
    
}




@end
