//
//  YFAnnoDescV.m
//  day35-map
//
//  Created by apple on 15/11/12.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAnnoDescV.h"
#import "YFAnno02.h"
#import "UIImageView+WebCache.h"

@interface  YFAnnoDescV ()
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *subtitle;
@property (nonatomic,strong)UIImageView *iv;
@end
@implementation YFAnnoDescV

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]){
        self.layer.anchorPoint=(CGPoint){.5,1.1};
        UIImage *img= img(@"bg_map_cell");
        CGFloat  w=img.size.width*.5;
        CGFloat h=img.size.height*.5;
        self.iv=[[UIImageView alloc] init ];

        self.iv.image=[img resizableImageWithCapInsets:(UIEdgeInsets){h,w,h,w} resizingMode:UIImageResizingModeStretch];
        [self addSubview:self.iv];
        
//        self.layer.anchorPoint=(CGPoint){.5,1.2};
        
        
        self.img=[[UIImageView alloc] init];
        self.title=[[UILabel alloc] init];
        self.subtitle=[[UILabel alloc] init];
        [self.subtitle setNumberOfLines:0];
        [self addSubview:self.img];
        [self addSubview:self.title];
        [self addSubview:self.subtitle];

        
        
//        CGFloat pad=8,imgw=60;
//        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.width.equalTo(@(imgw));
//            make.leading.top.equalTo(@(pad));
//            make.bottom.equalTo(@(-pad));
//        }];
//        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.img.mas_right).offset(pad);
//            make.top.equalTo(self.img);
//            make.width.equalTo(@100);
//            make.right.equalTo(@(pad));
//            make.height.equalTo(@18);
//
//        }];
//        [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.equalTo(self.title);
//            make.top.equalTo(self.title.mas_bottom).offset(pad);
//            make.width.equalTo(self.title);
//            make.bottom.equalTo(@(-pad));
//        }];

    }
    return self;
}



-(void)setAnno:(YFAnno02 *)anno{
    _anno=anno;
    self.subtitle.text=_anno.desc;
    self.title.text=_anno.title;
    self.img.image=img(_anno.image);
    
    CGFloat pad=8,imgw=60,w=190;
    self.img.frame=(CGRect){pad,pad,imgw,imgw};
    CGSize tsize=[_anno.title boundingRectWithSize:(CGSize){w-pad*3-imgw,18} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:0].size;
    CGSize dsize=[_anno.desc boundingRectWithSize:(CGSize){w-pad*3-imgw,CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:0].size;
    self.title.frame=(CGRect){pad*2+imgw,pad,tsize};
    self.subtitle.frame=(CGRect){pad*2+imgw,pad*2+18,dsize};
    CGFloat  y=CGRectGetMaxY(self.subtitle.frame),
    y2=CGRectGetMaxY(self.img.frame);
    
    
    self.bounds=(CGRect){0,0,w,(y>y2?y:y2)+pad*3};

    self.iv.frame=(CGRect){0,0,self.bounds.size};
    
    
}









@end
