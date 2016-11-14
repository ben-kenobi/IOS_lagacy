

//
//  YFHomePopSubCell.m
//  day30-tuangou
//
//  Created by apple on 15/11/8.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomePopSubCell.h"

@implementation YFHomePopSubCell

+(instancetype)cellWithTv:(UITableView *)tv{
    static NSString *iden=@"homepopsubcelliden";
    YFHomePopSubCell *cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImageView *bg = [[UIImageView alloc] initWithImage:img(@"bg_dropdown_rightpart")];

        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] initWithImage:img(@"bg_dropdown_right_selected")];

        self.selectedBackgroundView = selectedBg;
    }
    return self;
}
@end
