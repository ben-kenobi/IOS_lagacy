





//
//  YFEmojiCell.m
//  day39-project01
//
//  Created by apple on 15/11/25.
//  Copyright (c) 2015年 yf. All rights reserved.
//

#import "YFEmojiCell.h"
#import "UIImage+GIF.h"

@interface YFEmojiCell ()
@property (nonatomic,weak)UIImageView *icon;

@end

@implementation YFEmojiCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        UIImageView *icon=[[UIImageView alloc] initWithFrame:self.bounds];
        self.icon=icon;
        [self.contentView addSubview:self.icon];
    }
    return self;
}


-(void)setImg:(UIImage *)img{
    _img=img;

    self.icon.image=img;
}

-(void)setUrl:(NSString *)url{
    _url=url;

    self.icon.image=[UIImage sd_animatedGIFWithData:iData4F(iRes(url))];
    
    
}
@end
