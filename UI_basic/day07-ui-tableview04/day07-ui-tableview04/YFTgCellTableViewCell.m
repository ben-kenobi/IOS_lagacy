//
//  YFTgCellTableViewCell.m
//  day07-ui-tableview04
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFTgCellTableViewCell.h"
#import "YFTg.h"

@interface YFTgCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *orice;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end

@implementation YFTgCellTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

-(void)setTg:(YFTg *)tg{
    if(_tg!=tg){
        _tg=tg;
        
        self.img.image=[UIImage imageNamed:tg.icon];
        self.title.text=tg.title;
        self.orice.text=[NSString stringWithFormat:@"¥%@",tg.price];
        self.count.text=[NSString stringWithFormat:@"buy:%@",tg.buyCount];
    }
}

@end
